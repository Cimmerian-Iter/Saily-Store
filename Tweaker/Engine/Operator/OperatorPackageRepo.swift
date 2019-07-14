//
//  OperatorPackageRepo.swift
//  Tweaker
//
//  Created by Lakr Aream on 2019/7/11.
//  Copyright © 2019 Lakr Aream. All rights reserved.
//

extension app_opeerator {
    
    // 下载release -> 下载软件包 -> 更新软件包到内存 -> 写入硬盘
    
    func PR_print_ram_status() {
        var download_count = 0
        for item in LKRoot.container_package_repo_download where item.value != "" {
            download_count += 1
            print("[i] 软件源 " + item.key + " 已经下载完成")
        }
        print("[i] 内存中共有 " + LKRoot.container_package_repo.count.description + " 个软件源 已经下载了 " + download_count.description + "/" + LKRoot.container_package_repo.count.description)
    }
    
    func PR_sync_and_download(sync_all: Bool, _ CallB: @escaping (Int) -> Void) {

        LKRoot.container_string_store["REFRESH_IN_POGRESS_PR"] = "TRUE"
        LKRoot.container_string_store["REFRESH_CONTAIN_BAD_REFRESH_PR"] = ""
        
        var repos: [DBMPackageRepos]
        guard let repo: [DBMPackageRepos] = try? LKRoot.root_db?.getObjects(on: [DBMPackageRepos.Properties.link,
                                                                                 DBMPackageRepos.Properties.icon,
                                                                                 DBMPackageRepos.Properties.name,
                                                                                 DBMPackageRepos.Properties.sort_id],
                                                                            fromTable: common_data_handler.table_name.LKPackageRepos.rawValue,
                                                                            orderBy: [DBMPackageRepos.Properties.sort_id.asOrder(by: .ascending)]) else {
                                                                                print("[E] 无法从 LKPackageRepos 中获得数据，终止同步。")
                                                                                LKRoot.container_string_store["REFRESH_IN_POGRESS_PR"] = "FALSE"
                                                                                LKRoot.container_string_store["REFRESH_CONTAIN_BAD_REFRESH_PR"] = ""
                                                                                CallB(operation_result.failed.rawValue)
                                                                                return
        } // guard let
        
        if sync_all {
            repos = repo
            LKRoot.container_package_repo.removeAll()
        } else {
            repos = [DBMPackageRepos]()
            var exists_repos = [DMPackageRepos]()
            // 移除不存在了的源
            for item in LKRoot.container_package_repo {
                var exists = false
                exists_check: for exs in repo where exs.link == item.link {
                    exists = true
                    break exists_check
                }
                if exists {
                   exists_repos.append(item)
                }
            }
            LKRoot.container_package_repo = exists_repos
            // 添加将要刷新的源
            for item in repo {
                var exists = false
                exists_check: for exs in LKRoot.container_package_repo where exs.link == (item.link ?? UUID().uuidString) {
                    exists = true
                    break exists_check
                }
                if !exists {
                    repos.append(item)
                }
            }
        }
        
        inner_01: for item in repos where item.link != nil && item.link != "" {
            // 下载内容
            let release_url = (item.link ?? "") + "Release"
            guard let url = URL(string: release_url) else {
                print("[Resumable - fatalError] 无法内容创建下载链接:" + (item.link ?? ""))
                LKRoot.container_string_store["REFRESH_CONTAIN_BAD_REFRESH_PR"]?.append(item.link!)
                continue inner_01
            }
            var read_release = ""
            let sem = DispatchSemaphore(value: 0)
            var finished = false
            print("[*] 准备从 " + url.absoluteString + " 请求数据。")
            AF.request(url, method: .get, headers: LKRoot.ins_networking.read_header()).response(queue: LKRoot.queue_dispatch) { (data) in
                if finished {
                    return
                }
                finished = true
                let str_data = data.data ?? Data()
                var str: String?
                str = String(data: str_data, encoding: .utf8)
                if str == nil {
                    str = String(data: str_data, encoding: .ascii)
                    if str == nil {                LKRoot.container_string_store["REFRESH_CONTAIN_BAD_REFRESH_PR"]?.append(item.link!)
                        str = """
                        Label: 未知错误
                        Description: 获取软件源元数据错误
                        """
                    }
                }
                read_release = str ?? ""
                sem.signal()
            }
            LKRoot.queue_dispatch.async {
                sleep(UInt32(LKRoot.settings?.network_timeout ?? 6))
                if !finished {
                    LKRoot.container_string_store["REFRESH_CONTAIN_BAD_REFRESH_PR"]?.append(item.link!)
                    read_release = """
                    Label: 未知错误
                    Description: 获取软件源元数据错误
                    """
                    finished = true
                    sem.signal()
                }
            }
            sem.wait()
            if read_release == "" {
                LKRoot.container_string_store["REFRESH_CONTAIN_BAD_REFRESH_PR"]?.append(item.link!)
                continue inner_01
            }
            read_release = read_release.cleanRN()
            // 发送给wrapper
            let out = PR_release_wrapper(str: read_release)
            let new = DMPackageRepos()
            new.link = item.link ?? ""
//            new.icon = (item.link ?? "") + "CydiaIcon@3x.png"
            new.icon = (item.link ?? "") + "CydiaIcon.png"
            new.item = out
            new.name = out["ORIGIN"] ?? "无名氏".localized()
            new.desstr = out["DESCRIPTION"] ?? ""
            LKRoot.container_package_repo.append(new)
            let db = new.to_data_base()
            try? LKRoot.root_db?.update(table: common_data_handler.table_name.LKPackageRepos.rawValue,
                                        on: [DBMPackageRepos.Properties.icon,
                                             DBMPackageRepos.Properties.name],
                                        with: db,
                                        where: DBMPackageRepos.Properties.link == item.link!)
        }
        LKRoot.container_string_store["REFRESH_IN_POGRESS_PR"] = "FALSE"
        let session = UUID().uuidString
        LKRoot.container_string_store["SESSION_ID_PACKAGE_REPO_SYNC"] = session
        CallB(operation_result.success.rawValue)
        LKRoot.queue_dispatch.async {
            self.PR_download_all_package(session_id: session, sync_all: sync_all) { (_) in
                
            }
        }
    } // PR_sync_and_download
    
    func PR_release_wrapper(str: String) -> [String : String] {
        var ret = [String : String]()
        for item in str.split(separator: "\n") {
            if item.uppercased().hasPrefix("Origin:".uppercased()) {
                ret["ORIGIN"] = item.dropFirst("Origin:".count).to_String().drop_space()
            } else if item.uppercased().hasPrefix("Description:".uppercased()) {
                ret["DESCRIPTION"] = item.dropFirst("Description:".count).to_String().drop_space()
            }
        }
        return ret
    } // PR_release_wrapper
    
    // 在call之前要先更换session然后手动解锁 LKRoot.container_string_store["IN_PROGRESS_DOWNLOAD_PACKAGE_REPOS"] = "NO"
    func PR_download_all_package(session_id: String, sync_all: Bool, _ CallB: @escaping (Int) -> Void) {
        if LKRoot.container_string_store["IN_PROGRESS_DOWNLOAD_PACKAGE_REPOS"] == "YES" || session_id != LKRoot.container_string_store["SESSION_ID_PACKAGE_REPO_SYNC"] {
            CallB(operation_result.another_in_progress.rawValue)
            return
        }
        
        var do_download = [DMPackageRepos]()
        LKRoot.container_string_store["STR_SIG_PROGRESS"] = "正在下载软件包，这可能需要一些时间。".localized()
        
        if sync_all {
            LKRoot.container_package_repo_download.removeAll()
            do_download = LKRoot.container_package_repo
        } else {
            // 更新下载缓存 删除被删除的源的下载缓存
            var download_cache = [String : String]()
            for item in LKRoot.container_package_repo_download {
                var exists = false
                for exs in LKRoot.container_package_repo where item.key == exs.link && item.value != "" {
                    exists = true
                    break
                }
                if exists {
                    download_cache[item.key] = item.value
                }
            }
            LKRoot.container_package_repo_download = download_cache
            // 构建需要下载的列表
            for item in LKRoot.container_package_repo {
                if LKRoot.container_package_repo_download[item.link] == nil || LKRoot.container_package_repo_download[item.link] == "" {
                    do_download.append(item)
                }
            }
            
        }
        
        for item in do_download {
            var found = false
            inner_search: for search_url in LKRoot.ins_networking.release_search_path where !found {
                guard let url = URL(string: item.link + search_url) else {
                    continue inner_search
                }
                // 检查文件扩展名
                var backend = ""
                if search_url.contains(".") {
                    backend = String(search_url.split(separator: ".").last ?? "")
                }
                let ss = DispatchSemaphore(value: 0)
                var finished = false
                print("[*] 准备从 " + url.absoluteString + " 请求数据。")
                if session_id != LKRoot.container_string_store["SESSION_ID_PACKAGE_REPO_SYNC"] {
                    return
                }
                AF.request(url, method: .get, headers: LKRoot.ins_networking.read_header()).response(queue: LKRoot.queue_dispatch) { (respond) in
                    finished = true
                    if respond.data == nil || session_id != LKRoot.container_string_store["SESSION_ID_PACKAGE_REPO_SYNC"] {
                        ss.signal()
                        return
                    }
                    
                    let raw_data = respond.data!
                    let out_data: Data
                    
                    switch backend {
                    case "bz", "bz2":
                        if let decompress_data = try? BZip2.decompress(data: raw_data) {
                            out_data = decompress_data
                        } else {
                            out_data = raw_data
                        }
                    case "gz", "gz2":
                        if let decompress_data = try? BZip2.decompress(data: raw_data) {
                            out_data = decompress_data
                        } else {
                            out_data = raw_data
                        }
                    default:
                        out_data = raw_data
                    }
                    
                    var str: String? = String(data: out_data, encoding: .utf8)
                    if str == nil {
                        str = String(data: out_data, encoding: .ascii)
                    }
                    if str == nil || str == "" || str?.hasPrefix("<!DOCTYPE") ?? false || str?.hasPrefix("<html>") ?? false || str?.hasPrefix("<?xml version=") ?? false {
                        ss.signal()
                        return
                    }
                    // yo! 找到正确的数据了！
                    if session_id != LKRoot.container_string_store["SESSION_ID_PACKAGE_REPO_SYNC"] {
                        ss.signal()
                        return
                    }
                    LKRoot.container_package_repo_download[item.link] = str!
                    found = true
                    ss.signal()
                    return
                }
                LKRoot.queue_dispatch.async {
                    sleep(UInt32(LKRoot.settings?.network_timeout ?? 6))
                    if finished || session_id != LKRoot.container_string_store["SESSION_ID_PACKAGE_REPO_SYNC"] {
                        return
                    }
                    finished = true
                    ss.signal()
                }
                ss.wait()
            } // inner_search
        }
        LKRoot.container_string_store["IN_PROGRESS_DOWNLOAD_PACKAGE_REPOS"] = "NO"
        LKRoot.container_string_store["STR_SIG_PROGRESS"] = "SIGCLEAR"
        
        PR_print_ram_status()
        
        CallB(operation_result.success.rawValue)
        
        LKRoot.queue_dispatch.async {
            self.PR_package_wrapper({ (_) in
            })
        }
    } // PR_download_all_package
    
    func PR_package_wrapper(_ CallB: @escaping (Int) -> Void) {
        LKRoot.container_string_store["STR_SIG_PROGRESS"] = "正在刷新软件包列表，这可能需要一些时间。".localized()
        
        LKRoot.container_string_store["STR_SIG_PROGRESS"] = "SIGCLEAR"
    }
    
    
}

/*
 
 9 to 8 I feel so grate
 7 to 6 need my hair fix
 5 to 4 what you waiting for
 3 2 1 let go have fun
 
 */