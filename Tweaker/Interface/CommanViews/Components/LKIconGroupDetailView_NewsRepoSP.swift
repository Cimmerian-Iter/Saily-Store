//
//  LKIconGroupDetailView_NewsRepoSP.swift
//  Tweaker
//
//  Created by Lakr Aream on 2019/7/8.
//  Copyright © 2019 Lakr Aream. All rights reserved.
//

class LKIconGroupDetailView_NewsRepoSP: UIView, UITableViewDataSource {
    
    var is_collapsed = true
    let contentView = UIView()
    let table_view_container = UIView()
    
    var from_father_view: UIView?
    
    let expend_button = UIButton()
    let collapse_button = UIButton()
    let table_view = UITableView()
    let icon_stack = LKIconStack()
    
    var sync_news_repos = [DMNewsRepo]()
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        table_view.register(LKIconTVCell.self, forCellReuseIdentifier: "LKIconGroupDetailView_NewsRepoSP_TVID")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func apart_init(father: UIView?) {
        
        LKRoot.container_manage_cell_status["NewsRepo"] = is_collapsed
        
        let RN_ANCHOR_O = 24
        let RN_ANCHOR_I = 16
        
        if father != nil {
            from_father_view = father!
        }
        
        sync_news_repos = LKRoot.container_news_repo
        
        contentView.setRadiusINT(radius: LKRoot.settings?.card_radius)
        contentView.backgroundColor = LKRoot.ins_color_manager.read_a_color("main_back_ground")
        contentView.addShadow(ofColor: LKRoot.ins_color_manager.read_a_color("shadow"))
        addSubview(contentView)
        contentView.snp.makeConstraints { (x) in
            x.top.equalTo(self.snp.top).offset(RN_ANCHOR_O)
            x.bottom.equalTo(self.snp.bottom).offset(-RN_ANCHOR_O)
            x.left.equalTo(self.snp.left).offset(RN_ANCHOR_O)
            x.right.equalTo(self.snp.right).offset(-RN_ANCHOR_O)
        }
        
        // 标题
        let title_view = UILabel()
        title_view.text = "新闻源".localized()
        title_view.textColor = LKRoot.ins_color_manager.read_a_color("main_title_two")
        title_view.font = .boldSystemFont(ofSize: 28)
        contentView.addSubview(title_view)
        title_view.snp.makeConstraints { (x) in
            x.top.equalTo(self.contentView.snp.top).offset(6)
            x.left.equalTo(self.contentView.snp.left).offset(RN_ANCHOR_I)
            x.height.equalTo(46)
            x.width.equalTo(188)
        }
        
        // 描述
        let sub_title_view = UITextView()
        sub_title_view.text = "这里包含了您在首页看到的所有新闻的来源。我们始终建议您只添加受信任的来源。".localized()
        sub_title_view.textColor = LKRoot.ins_color_manager.read_a_color("sub_text")
        sub_title_view.font = .systemFont(ofSize: 10)
        sub_title_view.isUserInteractionEnabled = false
        sub_title_view.backgroundColor = .clear
        contentView.addSubview(sub_title_view)
        sub_title_view.snp.makeConstraints { (x) in
            x.top.equalTo(title_view.snp.bottom).offset(0)
            x.left.equalTo(self.contentView.snp.left).offset(RN_ANCHOR_I - 4)
            x.right.equalTo(self.contentView.snp.right).offset(-RN_ANCHOR_I + 4)
            x.height.equalTo(sub_title_view.sizeThatFits(CGSize(width: UIScreen.main.bounds.width - 92, height: .infinity)))
        }
        
        // 分割线
        let sep = UIView()
        sep.backgroundColor = LKRoot.ins_color_manager.read_a_color("tabbar_untint")
        sep.alpha = 0.3
        contentView.addSubview(sep)
        sep.snp.makeConstraints { (x) in
            x.top.equalTo(sub_title_view.snp.bottom).offset(6)
            x.left.equalTo(self.contentView.snp.left)
            x.right.equalTo(self.contentView.snp.right)
            x.height.equalTo(0.5)
        }
        
        // 图标组
        var icon_addrs = [String]()
        for item in sync_news_repos {
            icon_addrs.append(item.icon)
        }
        icon_stack.images_address = icon_addrs
        icon_stack.apart_init()
        contentView.addSubview(icon_stack)
        icon_stack.snp.makeConstraints { (x) in
            x.right.equalTo(self.contentView.snp.right).offset(RN_ANCHOR_I)
            x.top.equalTo(self.contentView.snp.top).offset(12)
            x.width.equalTo(2)
            x.height.equalTo(33)
        }
        
        contentView.addSubview(table_view_container)
        table_view_container.clipsToBounds = true
        table_view_container.snp.makeConstraints { (x) in
            x.top.equalTo(sep.snp.bottom).offset(18)
            x.left.equalTo(contentView.snp.left).offset(8)
            x.right.equalTo(contentView.snp.right).offset(-8)
            x.bottom.equalTo(contentView.snp.bottom).offset(-8)
        }
        
        // 展开按钮
        expend_button.setTitle("点击来展开全部新闻源 ▼".localized(), for: .normal)
        expend_button.titleLabel?.font = .boldSystemFont(ofSize: 12)
        expend_button.setTitleColor(LKRoot.ins_color_manager.read_a_color("main_title_two"), for: .normal)
        expend_button.setTitleColor(.gray, for: .highlighted)
        contentView.addSubview(expend_button)
        expend_button.snp.remakeConstraints { (x) in
//            x.bottom.equalTo(self.contentView.snp.bottom)
            x.height.equalTo(30)
            x.top.equalTo(sep.snp.bottom)
            x.left.equalTo(self.contentView.snp.left)
            x.right.equalTo(self.contentView.snp.right)
        }
        
        // 关闭按钮
        collapse_button.setTitle("收起 ▲".localized(), for: .normal)
        collapse_button.titleLabel?.font = .boldSystemFont(ofSize: 12)
        collapse_button.setTitleColor(LKRoot.ins_color_manager.read_a_color("main_title_two"), for: .normal)
        collapse_button.setTitleColor(.gray, for: .highlighted)
        collapse_button.isHidden = true
        contentView.addSubview(collapse_button)
        collapse_button.snp.makeConstraints { (x) in
            x.centerY.equalTo(title_view.snp.centerY)
            x.right.equalTo(self.contentView.snp.right).offset(-RN_ANCHOR_I)
        }
        
        collapse_button.bringSubviewToFront(contentView)
        contentView.bringSubviewToFront(self)
        
        table_view.delegate = self
        table_view.dataSource = self
        table_view.isHidden = true
        table_view_container.addSubview(table_view)
        table_view.snp.makeConstraints { (x) in
            x.top.equalTo(self.table_view_container.snp.top)
            x.left.equalTo(contentView.snp.left).offset(8)
            x.right.equalTo(contentView.snp.right).offset(-8)
            x.height.equalTo(LKRoot.container_news_repo.count * 62)
        }
        table_view.separatorColor = .clear
        table_view.backgroundColor = .clear
        table_view.beginUpdates()
        table_view.reloadData()
        table_view.endUpdates()
        
        expend_button.addTarget(self, action: #selector(expend_self), for: .touchUpInside)
        collapse_button.addTarget(self, action: #selector(collapse_self), for: .touchUpInside)
        
    }

    func update_status() {
        LKRoot.container_manage_cell_status["NewsRepo"] = is_collapsed
    }
    
    @objc func expend_self() {
        
        if !(LKRoot.container_refresh_ready["NewsRepos"] ?? false) {
            UIView.animate(withDuration: 0.5, animations: {
                self.expend_button.setTitle("请等待首页刷新进程完成".localized(), for: .normal)
            })
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                UIView.animate(withDuration: 0.5, animations: {
                    self.expend_button.setTitle("点击来展开全部新闻源 ▼".localized(), for: .normal)
                })
            }
            return
        }
        
        // 更新缓存
        sync_news_repos = LKRoot.container_news_repo
        table_view.reloadData()
        table_view.snp.remakeConstraints { (x) in
            x.top.equalTo(self.table_view_container.snp.top)
            x.left.equalTo(contentView.snp.left).offset(8)
            x.right.equalTo(contentView.snp.right).offset(-8)
            x.height.equalTo(LKRoot.container_news_repo.count * 62)
        }
        expend_button.setTitle("点击来展开全部新闻源 ▼".localized(), for: .normal)
        var icon_addrs = [String]()
        for item in sync_news_repos {
            icon_addrs.append(item.icon)
        }
        icon_stack.images_address = icon_addrs
        icon_stack.apart_init()
        
        if !is_collapsed {
            update_status()
            return
        }
        is_collapsed = false
        update_status()
        // 起始状态
        collapse_button.alpha = 0
        collapse_button.isHidden = false
        table_view.alpha = 0
        table_view.isHidden = false
        UIApplication.shared.beginIgnoringInteractionEvents()
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        DispatchQueue.main.async {
            (self.from_father_view as? UITableView)?.beginUpdates()
            UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
                (self.from_father_view as? UITableView)?.endUpdates()
                self.expend_button.alpha = 0
                self.collapse_button.alpha = 1
                self.icon_stack.alpha = 0
                self.table_view.alpha = 1
            }, completion: { (_) in
                self.expend_button.isHidden = true
                self.icon_stack.isHidden = true
                UIApplication.shared.endIgnoringInteractionEvents()
            })
        }
    }
    
    @objc func collapse_self() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        if is_collapsed {
            update_status()
            return
        }
        is_collapsed = true
        update_status()
        // 起始状态
        expend_button.alpha = 0
        expend_button.isHidden = false
        icon_stack.alpha = 0
        icon_stack.isHidden = false
        UIApplication.shared.beginIgnoringInteractionEvents()
        DispatchQueue.main.async {
            (self.from_father_view as? UITableView)?.beginUpdates()
            UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
                (self.from_father_view as? UITableView)?.endUpdates()
                self.collapse_button.alpha = 0
                self.expend_button.alpha = 1
                self.icon_stack.alpha = 1
                self.table_view.alpha = 0
            }, completion: { (_) in
                self.collapse_button.isHidden = true
                self.table_view.isHidden = true
                UIApplication.shared.endIgnoringInteractionEvents()
            })
        }
    }
    
}

extension LKIconGroupDetailView_NewsRepoSP: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sync_news_repos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ret = tableView.dequeueReusableCell(withIdentifier: "LKIconGroupDetailView_NewsRepoSP_TVID", for: indexPath) as? LKIconTVCell ?? LKIconTVCell()
        ret.icon.sd_setImage(with: URL(string: sync_news_repos[indexPath.row].icon), placeholderImage: UIImage(named: "Gary")) { (img, err, _, _) in
            if err != nil || img == nil {
                ret.icon.image = UIImage(named: "AppIcon")
            }
        }
        ret.title.text = sync_news_repos[indexPath.row].name
        ret.link.text = sync_news_repos[indexPath.row].link
        ret.backgroundColor = .clear
        return ret
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 62
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table_view.deselectRow(at: indexPath, animated: true)
    }
}
