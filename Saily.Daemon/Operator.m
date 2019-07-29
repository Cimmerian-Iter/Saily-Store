//
//  Operator.m
//  Saily.Daemon
//
//  Created by Lakr Aream on 2019/7/21.
//  Copyright © 2019 Lakr Aream. All rights reserved.
//

#import "Operator.h"

BOOL IN_FORCE_ROOT_APP = false;

NSString *LKRDIR = @"";
int daemon_status = 0;

int read_status() {
    return daemon_status;
}

NSString *readAppPath() {
    return LKRDIR;
}

void setAppPath(NSString *string) {
    
    if ([string containsString:@"/var/mobile/Containers/Data/Application/"] && IN_FORCE_ROOT_APP) {
        NSLog(@"[*] 不允许沙箱内 App 启用此版本 daemon: %@", string);
        exit(9);
    }
    
    LKRDIR = string;
    NSLog(@"[*] 将 daemon 初始化到应用程序路径: %@", string);
//    redirectConsoleLogToDocumentFolder();
    
    void *lib = dlopen("/usr/lib/libMobileGestalt.dylib", RTLD_GLOBAL | RTLD_LAZY);
    CFStringRef (*MGCopyAnswer)(CFStringRef) = (CFStringRef (*)(CFStringRef))(dlsym(lib, "MGCopyAnswer"));
    NSString *udidret = CFBridgingRelease(MGCopyAnswer(CFSTR("UniqueDeviceID")));
    // Do not log it cause it may be redirect.
//    NSLog(@"%@", udid_Ret);
    NSString *udidPath = [[NSString alloc] initWithFormat: @"%@/ud.id", LKRDIR];
    [udidret writeToFile: udidPath atomically:true encoding: NSUTF8StringEncoding error:nil];
    fix_permission();
}

void outDaemonStatus() {
    if ([LKRDIR isEqualToString:@""]) {
        NSLog(@"[E] 路径顺序不合法");
        return;
    }
    usleep(2333);
    NSString *status_str = @"unknown";
    switch (daemon_status) {
        case 0:
            status_str = @"ready";
            break;
        case 1:
            status_str = @"busy";
        default:
            break;
    }
    NSString *echo = [[NSString alloc] initWithFormat: @"echo %@ >> %@/daemon.call/status.txt", status_str, LKRDIR];
    run_cmd((char *)[echo UTF8String]);
    fix_permission();
}

void executeScriptFromApplication() {
    NSLog(@"[*] 准备执行用户脚本");
    
    if ([LKRDIR  isEqual: @""]) {
        NSLog(@"[*] 不允许未初始化的实例执行脚本");
        return;
    }
    
    NSString *test = [[NSString alloc] initWithFormat: @"%@/daemon.call/requestScript.txt", LKRDIR];
    if (![[NSFileManager defaultManager] fileExistsAtPath: test]) {
        NSLog(@"[*] 脚本文件不存在，拒绝执行");
        return;
    }
    
    NSString *mkdir = @"mkdir -p /var/root/Saily.Daemon";
    NSString *cp = [[NSString alloc] initWithFormat: @"cp %@/daemon.call/requestScript.txt /var/root/Saily.Daemon/requestScript.txt", LKRDIR];
    NSString *chmod = [[NSString alloc] initWithFormat: @"chmod +x /var/root/Saily.Daemon/requestScript.txt"];
    NSString *bash = [[NSString alloc] initWithFormat: @"bash /var/root/Saily.Daemon/requestScript.txt"];
    
    run_cmd((char *)[mkdir UTF8String]);
    run_cmd((char *)[cp UTF8String]);
    run_cmd((char *)[chmod UTF8String]);
    run_cmd((char *)[bash UTF8String]);
    NSLog(@"[*] 执行完成 ✅");
    fix_permission();
}

void executeRespring() {
    NSString *cmd = @"killall backboardd";
    run_cmd((char *)[cmd UTF8String]);
    NSLog(@"[*] 注销完成");
    exit(0);
}

extern char **environ;
void run_cmd(char *cmd) {
    pid_t pid;
    char *argv[] = {"sh", "-c", cmd, NULL, NULL};
    int status;
    
    NSString *cmdStr = [[NSString alloc] initWithUTF8String: cmd];
    NSLog(@"[Execute] sh -c %@", cmdStr);
    
    status = posix_spawn(&pid, "/bin/sh", NULL, NULL, argv, environ);
    if (status == 0) {
        if (waitpid(pid, &status, 0) == -1) {
            perror("waitpid");
        }
    }
}

void fix_permission() {
    NSString *com = [[NSString alloc] initWithFormat:@"chmod -R 777 %@/", LKRDIR];
    run_cmd((char *)[com UTF8String]);
    com = [[NSString alloc] initWithFormat:@"chown -R 501:501 %@/", LKRDIR];
    run_cmd((char *)[com UTF8String]);
}

void redirectConsoleLogToDocumentFolder() {
    if ([LKRDIR isEqualToString:@""]) {
        NSLog(@"[E] 路径顺序不合法");
        return;
    }
    NSString *logPath = [LKRDIR stringByAppendingPathComponent:@"/daemon.call/console.txt"];
    NSString *echo = [[NSString alloc] initWithFormat: @"echo init >> %@/daemon.call/console.txt", LKRDIR];
    run_cmd((char *)[echo UTF8String]);
    fix_permission();
    freopen([logPath fileSystemRepresentation], "a+", stderr);
    NSLog(@"[*] 重定向输出到文件： %@", logPath);
}

void redirectConsoleLogToVarRoot() {
    NSString *mkdir = @"mkdir -p /var/root/Saily.Daemon/";
    run_cmd((char *)[mkdir UTF8String]);
    NSString *logPath = @"/var/root/Saily.Daemon/out";
    freopen([logPath fileSystemRepresentation], "a+", stderr);
    NSLog(@"[*] 重定向输出到文件： %@", logPath);
}

void requiredBackUpDocumentFiles() {
    if ([LKRDIR isEqualToString:@""]) {
        NSLog(@"[E] 路径顺序不合法");
        return;
    }
    NSLog(@"准备执行存档备份");
    NSString *rm = @"rm -rf /var/root/Saily.Database.Backup";
    NSString *cp = [[NSString alloc] initWithFormat: @"cp -r %@ /var/root/Saily.Database.Backup", LKRDIR];
    NSString *rmrf = @"rm -rf /var/root/Saily.Database.Backup/daemon.call";
    NSString *rmrff = @"rm -rf /var/root/Saily.Database.Backup/dpkg";
    run_cmd((char *)[rm UTF8String]);
    run_cmd((char *)[cp UTF8String]);
    run_cmd((char *)[rmrf UTF8String]);
    run_cmd((char *)[rmrff UTF8String]);
    NSLog(@"存档备份完成");
}

void requiredRestoreBackup() {
    NSLog(@"准备从备份恢复存档");
    if ([LKRDIR isEqualToString:@""]) {
        NSLog(@"[E] 路径顺序不合法");
        return;
    }
    if (![[NSFileManager defaultManager] fileExistsAtPath: @"/var/root/Saily.Database.Backup"]) {
        NSLog(@"[E] 没有备份文件");
        NSString *err = [[NSString alloc] initWithFormat: @"echo Error &> %@/daemon.call/errRestore", LKRDIR];
        run_cmd((char *)[err UTF8String]);
        fix_permission();
        return;
    }
    NSString *begin = [[NSString alloc] initWithFormat: @"echo Start &> %@/daemon.call/resotreInProgress", LKRDIR];
    NSString *cp = @"cp -r /var/root/Saily.Database.Backup /var/root/Saily.Database.Backup.bak";
    NSString *mv = [[NSString alloc] initWithFormat: @"mv /var/root/Saily.Database.Backup.bak/* %@/", LKRDIR];
    NSString *rm = [[NSString alloc] initWithFormat: @"rm -rf /var/root/Saily.Database.Backup.bak"];
    NSString *end = [[NSString alloc] initWithFormat: @"echo End &> %@/daemon.call/resotreCompleted", LKRDIR];
    run_cmd((char *)[begin UTF8String]);
    run_cmd((char *)[cp UTF8String]);
    run_cmd((char *)[mv UTF8String]);
    run_cmd((char *)[rm UTF8String]);
    run_cmd((char *)[end UTF8String]);
    fix_permission();
    NSLog(@"存档恢复完成");
}

void requiredRestoreCheck() {
    if ([LKRDIR isEqualToString:@""]) {
        NSLog(@"[E] 路径顺序不合法");
        return;
    }
    if ([[NSFileManager defaultManager] fileExistsAtPath: @"/var/root/Saily.Database.Backup"]) {
        NSString *put = [[NSString alloc] initWithFormat: @"echo Exists &> %@/daemon.call/shouldRestore", LKRDIR];
        run_cmd((char *)[put UTF8String]);
        fix_permission();
        return;
    }
}

void requiredImportAPT() {
    if ([LKRDIR isEqualToString:@""]) {
        NSLog(@"[E] 路径顺序不合法");
        return;
    }
    NSString *mkdir = [[NSString alloc] initWithFormat: @"mkdir -p %@/daemon.call/import/", LKRDIR];
    NSString *cp = [[NSString alloc] initWithFormat: @"cp -L /etc/apt/sources.list.d/* %@/daemon.call/import/", LKRDIR];
    NSString *sig = [[NSString alloc] initWithFormat: @"echo Ended &>  %@/daemon.call/completedSourceImport", LKRDIR];
    run_cmd((char *)[mkdir UTF8String]);
    run_cmd((char *)[cp UTF8String]);
    run_cmd((char *)[sig UTF8String]);
    fix_permission();
    
}

void requiredUnlockDPKG() {
    NSLog(@"准备解锁 dpkg 请注意系统环境");
    NSString *kill = [[NSString alloc] initWithFormat: @"killall -SEGV dpkg"];
    NSString *rm = [[NSString alloc] initWithFormat: @"rm -rf /Library/dpkg/lock"];
    NSString *rmf = [[NSString alloc] initWithFormat: @"rm -rf /Library/dpkg/lock-frontend"];
    run_cmd((char *)[kill UTF8String]);
    run_cmd((char *)[rm UTF8String]);
    run_cmd((char *)[rmf UTF8String]);
    NSLog(@"[*] 执行完成 ✅");
}

void requiredUnlockNetwork() {
    NSLog(@"准备解锁网络环境");
    NSString *rm = [[NSString alloc] initWithFormat: @"rm -r /var/preferences/com.apple.networkextension*"];
    NSString *reboot = [[NSString alloc] initWithFormat: @"kill -SEGV 1"]; // I like it
//    NSString *justincause = [[NSString alloc] initWithFormat: @"killall SpringBoard"];
    run_cmd((char *)[rm UTF8String]);
    run_cmd((char *)[reboot UTF8String]);
//    run_cmd((char *)[justincause UTF8String]);
    NSLog(@"[*] 执行完成 ✅");
}

void requiredUICACHE() {
    NSLog(@"准备刷新桌面缓存");
    NSString *uicache = [[NSString alloc] initWithFormat: @"uicache -a"];
    run_cmd((char *)[uicache UTF8String]);
    NSLog(@"[*] 执行完成 ✅");
}
