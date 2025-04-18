-- 创建数据库
CREATE DATABASE `XXXXXX_tools`

-- 用户表
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL,
    role VARCHAR(20) DEFAULT 'user',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 任务表
CREATE TABLE tasks (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    type VARCHAR(50),
    start_date DATE,
    due_date DATE,
    status VARCHAR(20),
    user_id INT,
    test_script TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- XXXXXX_tools.api_tests definition

CREATE TABLE `api_tests` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `method` enum('GET','POST','PUT','DELETE','PATCH') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `path` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `version` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT 'v1',
  `headers` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `params` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `body` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `remark` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `collection_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `api_tests_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 测试报告表（推断）
CREATE TABLE test_reports (
    id INT AUTO_INCREMENT PRIMARY KEY,
    task_name VARCHAR(100),
    execution_time DATETIME,
    status VARCHAR(20),
    total_tests INT,
    passed_tests INT,
    failed_tests INT,
    skipped_tests INT,
    html_report_path VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- CURL执行记录表
CREATE TABLE api_curl (
    id INT AUTO_INCREMENT PRIMARY KEY,
    curl_command TEXT NOT NULL,
    execution_time FLOAT,
    status VARCHAR(50),
    response TEXT,
    error TEXT,
    created_at DATETIME,
    user_id INT,
    FOREIGN KEY (user_id) REFERENCES users(id)
);


CREATE TABLE IF NOT EXISTS excel_diff (
    id SERIAL PRIMARY KEY,
    file1_path TEXT NOT NULL,
    file2_path TEXT NOT NULL,
    file1_name TEXT NOT NULL,
    file2_name TEXT NOT NULL,
    diff_method TEXT NOT NULL,
    created_at TIMESTAMP NOT NULL,
    user_id INTEGER NOT NULL
);



CREATE TABLE IF NOT EXISTS locust_executions (
            id INT AUTO_INCREMENT PRIMARY KEY,
            execution_id VARCHAR(50) NOT NULL,
            executor VARCHAR(100) NOT NULL,
            script_name VARCHAR(255) NOT NULL,
            target_host VARCHAR(255) NOT NULL,
            num_users INT NOT NULL,
            spawn_rate INT NOT NULL,
            run_time VARCHAR(50) NOT NULL,
            start_time DATETIME NOT NULL,
            end_time DATETIME NULL,
            status VARCHAR(20) NOT NULL,
            result_file VARCHAR(255) NULL,
            total_requests INT NULL,
            failed_requests INT NULL,
            avg_response_time FLOAT NULL,
            success_rate FLOAT NULL,
            notes TEXT NULL
        );


 TABLE IF NOT EXISTS tool_configs (
                    id VARCHAR(50) PRIMARY KEY,
                    tool_name VARCHAR(100) NOT NULL,
                    config_value TEXT,
                    remark TEXT,
                    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
                );

-- 插入工具配置数据
INSERT INTO tool_configs (id, tool_name, config_value, remark) VALUES 
('api_platform', 'API测试平台', '默认API配置', '用于API测试的主平台'),
('ai_case_tool', 'AI测试用例生成工具', 'OpenAI API配置', '基于AI生成测试用例'),
('task_platform', '任务调度平台', '调度服务配置', '管理测试任务调度'),
('report_viewer', '查看执行报告', '报告存储路径', '查看测试执行报告'),
('curl_tool', 'CURL执行工具', 'CURL命令配置', '执行CURL命令测试接口'),
('excel_diff', 'Excel对比工具', 'Excel文件路径', '比较Excel文件差异'),
('zentao_report', '禅道报告', '禅道API配置', '生成禅道测试报告'),
('data_generator', '数据生成工具', '数据模板配置', '生成测试数据'),
('perf_test', '性能测试工具', 'Locust配置', '执行性能测试');



-- 生成用例存储问题 
     CREATE TABLE IF NOT EXISTS ai_case (
            id INT AUTO_INCREMENT PRIMARY KEY,
            用例编号 VARCHAR(50),
            用例标题 VARCHAR(255),
            前置条件 TEXT,
            测试数据 TEXT,
            操作步骤 TEXT,
            预期结果 TEXT,
            优先级 VARCHAR(10),
            是否执行 TINYINT DEFAULT 0,
            执行人 VARCHAR(50) DEFAULT '',
            创建时间 TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        ) ;



-- 测试集合表
CREATE TABLE `api_collections` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `user_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `api_collections_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ;

-- 批量执行接口测试结果表
CREATE TABLE IF NOT EXISTS `batch_execution_results` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `batch_id` VARCHAR(50) NOT NULL COMMENT '批次ID',
  `test_id` INT NOT NULL COMMENT '关联的api_tests表ID',
  `name` VARCHAR(100) NOT NULL COMMENT '接口名称',
  `method` VARCHAR(10) NOT NULL COMMENT '请求方法',
  `url` TEXT NOT NULL COMMENT '请求URL',
  `status_code` VARCHAR(10) COMMENT 'HTTP状态码',
  `response_time` FLOAT COMMENT '响应时间(秒)',
  `success` TINYINT(1) DEFAULT 0 COMMENT '是否成功',
  `response` TEXT COMMENT '响应内容',
  `error` TEXT COMMENT '错误信息',
  `user_id` INT NOT NULL COMMENT '执行用户ID',
  `executed_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '执行时间',
  FOREIGN KEY (test_id) REFERENCES api_tests(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
) ;

-- 批量执行汇总表
CREATE TABLE IF NOT EXISTS `batch_execution_summary` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `batch_id` VARCHAR(50) NOT NULL COMMENT '批次ID',
  `name` VARCHAR(100) COMMENT '批次名称',
  `total_tests` INT DEFAULT 0 COMMENT '总测试数',
  `success_tests` INT DEFAULT 0 COMMENT '成功测试数',
  `failed_tests` INT DEFAULT 0 COMMENT '失败测试数',
  `user_id` INT NOT NULL COMMENT '执行用户ID',
  `start_time` TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '开始时间',
  `end_time` TIMESTAMP NULL COMMENT '结束时间',
  `report_path` VARCHAR(255) COMMENT '报告文件路径',
  FOREIGN KEY (user_id) REFERENCES users(id)
);