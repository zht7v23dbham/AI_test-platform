# AI_test-platform

- streamlit run main.py  #执行
- streamlit run main.py --server.port 8080  #指定端口

_____________
'''
#文件目录：
 -   1.main.py #主文件
 -       1.1.登录页面
 -       1.2.注册页面
 -       1.3.api_manager.py #api管理页面
 -           1.3.1.api_test.py - 包含API测试相关功能
 -           1.3.2.api_management.py - 包含接口管理相关功能
 -           1.3.3.batch_execution.py - 包含批量执行相关功能
 -           1.3.4.md_parser.py - 包含Markdown解析相关功能
 -       1.4.tasks.py #任务管理页面
 -       1.5.utils.py #工具函数
 -       1.6.api_curl.py #curl 测试页面
 -       1.7.zentao.py #禅道页面报告
 -       1.8.excel_diff.py #excel 对比页面
 -       1.9.api_locust.py #locust 测试页面
 -       1.10.ai_case_test.py #ai 测试用例页面
 -       1.11.db_utils.py #数据库工具函数
 -       1.12.- git_commit_code.py : 提交代码功能
 -               code_diff.py : 代码对比功能
 -               git_resolve_conflicts.py : 冲突解决功能
 -               git_utils.py : Git操作记录工具函数
 -   2.requirements.txt #依赖文件
 -   3.README.md #说明文件
 -   4.db.json #数据库文件
 -   5.venv #虚拟环境
 -   6.locust_files #locust 测试文件
 -   7.locust_resutlts #locust 测试报告
 
 -   8..gitignore #git 忽略文件
'''
_____________


- cd /XXXX/XXXX-qa-task-tools
python3 -m venv venv

- source venv_py311/bin/activate

___________________________
# 基于streamlit+AI模型测试工具平台
# API测试平台：基本实现apifox 自动化测试功能，支持导入md数据转化接口用例，（后续支持批量测试）
# AI测试用例生成平台：  支持通过需求文档基于AI转化测试导出用例支持多种格式 
# 性能测试平台：支持locust 脚本性能测试
# 数据生成平台：支持csv 等测试数据生成
# CURL执行平台：支持媒体类接口请求记录
# Excel对比平台：支持配置化原始文件对比
# 禅道报告：支持基于禅道查询个时间段数据
# HAR执行平台：支持导出HAR执行 
# UI自动化平台：支持YAML脚本执行Maestro UI测试
# MD转脑图平台：MD  转导图和流程图
# 界面解析平台：支持单页面元素和内容解析   （后续实现基于playwright 解析多个界面）
# 安全测试平台：暂时支持sqlmap
# Al模型配置: 支持云模型和本地模型设置
# Git管理平台：支持本系统代码提交gitlib
# jenkins管理平台： 支持现有所有Jenkins环境发布执行
#
![image](https://github.com/user-attachments/assets/37daf30b-e3ca-46b6-916b-37d1efcb22c9)

#
#部分功能截图
###AI生成用例
![image](https://github.com/user-attachments/assets/3b2c2233-2dca-4ac2-a4d4-d5ae28d6aa21)
###界面功能解析
![image](https://github.com/user-attachments/assets/dd5f8e24-2932-4a53-aca1-b61583123cc1)

___________________________
#整体说明
## 主要页面和功能模块
1. 主程序入口 ：
   
   - main.py - 应用程序的主入口，负责整合各个功能模块
2. 认证与用户管理 ：
   
   - auth.py - 用户认证和权限管理
   - login_app.py - 登录界面
3. 任务管理 ：
   
   - tasks.py - 测试任务管理功能
   - batch_execution.py - 批量执行任务
4. Jenkins集成 ：
   
   - jenkins_manager.py - Jenkins任务管理和构建历史查看
   - jenkins_config.json - Jenkins配置文件
5. Git版本控制 ：
   
   - git_manager.py - Git仓库管理
   - git_utils.py - Git工具函数
   - git_commit_code.py - 代码提交功能
   - git_resolve_conflicts.py - 冲突解决工具
6. API测试工具 ：
   
   - api_manager.py - API管理
   - api_test.py - API测试
   - api_curl.py - cURL命令生成和执行
   - api_locust.py - Locust性能测试
   - api_mitmproxy.py - 代理抓包工具
   - har_executor.py - HAR文件执行器
7. 数据库工具 ：
   
   - db_utils.py - 数据库工具函数
   - text_to_mysql.py - 文本转SQL工具
8. UI解析工具 ：
   
   - ui_parser.py - UI页面解析工具
9. 禅道报告 ：
   
   - zentao_report.py - 禅道测试报告生成
10. 其他工具 ：
    
    - excel_diff.py - Excel文件比较
    - code_diff.py - 代码比较
    - md_parser.py - Markdown解析
    - linux_monitor.py - Linux系统监控
## 文件夹结构
1. base/ - 基础组件和工具
2. data/ - 数据文件存储
3. diff_screenshots/ - 差异截图存储
4. locust_files/ - Locust测试脚本
5. locust_results/ - Locust测试结果
6. output/mindmaps/ - 思维导图输出
## 技术栈
1. 前端框架 ：Streamlit
2. 后端 ：Python
3. 数据库 ：MySQL
4. 版本控制 ：Git
5. CI/CD ：Jenkins
6. 测试工具 ：Locust, mitmproxy
7. 数据可视化 ：Plotly
## 页面流程
1. 用户通过 login_app.py 登录系统
2. 登录后进入 main.py 定义的主界面
3. 用户可以选择不同的功能模块：
   - 任务管理
   - Jenkins管理
   - Git仓库管理
   - API测试
   - 数据库工具
   - UI解析
   - 报告生成等
