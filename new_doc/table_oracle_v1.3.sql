
-- QRTZ_APP
DROP TABLE QRTZ_APP;
DROP TABLE QRTZ_NODE;
DROP TABLE QRTZ_JOB;
DROP TABLE QRTZ_EXECUTE;

CREATE TABLE QRTZ_APP(
  APPLICATION VARCHAR2(50),
  STATE VARCHAR2(10) NOT NULL,
  TIME_PRE  NUMBER(18,0) DEFAULT -1,
  TIME_NEXT NUMBER(18,0) NOT NULL,
  TIME_INTERVAL NUMBER(18,0),
  PRIMARY KEY (APPLICATION)
);

COMMENT ON TABLE QRTZ_APP IS '定时任务::应用表';
COMMENT ON COLUMN QRTZ_APP.APPLICATION IS '调度名称/应用名称';
COMMENT ON COLUMN QRTZ_APP.STATE IS '状态 N.停止/不可用  Y.开启/可用';
COMMENT ON COLUMN QRTZ_APP.TIME_PRE IS '上一次check时间';
COMMENT ON COLUMN QRTZ_APP.TIME_NEXT IS '下一次check时间';
COMMENT ON COLUMN QRTZ_APP.TIME_INTERVAL IS 'check的检查间隔(毫秒)';

-- QRTZ_NODE
CREATE TABLE QRTZ_NODE(
  APPLICATION VARCHAR2(50),
  HOST_IP VARCHAR2(50) NOT NULL,
  HOST_NAME VARCHAR2(80) NOT NULL,
  STATE CHAR(1) NOT NULL,
  TIME_CHECK NUMBER(18,0) NOT NULL,
  PRIMARY KEY (APPLICATION,HOST_IP)
);

COMMENT ON TABLE QRTZ_NODE IS '定时任务::节点实例表';
COMMENT ON COLUMN QRTZ_NODE.APPLICATION IS '调度名称/应用名称';
COMMENT ON COLUMN QRTZ_NODE.HOST_IP IS '实例机器IP';
COMMENT ON COLUMN QRTZ_NODE.HOST_NAME IS '实例机器名称';
COMMENT ON COLUMN QRTZ_NODE.STATE IS '状态 N.停止/不可用  Y.开启/可用';
COMMENT ON COLUMN QRTZ_NODE.TIME_CHECK IS '检查时间';

-- QRTZ_JOB
CREATE TABLE QRTZ_JOB(
  ID NUMBER(18,0),
  APPLICATION VARCHAR2(50) NOT NULL,
  STATE VARCHAR2(10) NOT NULL,
  JOB_CLASS VARCHAR2(127) NOT NULL,
  JOB_DATA VARCHAR2(255),
  JOB_DESCRIPTION VARCHAR2(100),
  UPDATE_TIME NUMBER(18,0) NOT NULL,
  PRIMARY KEY (ID)
);
-- ALTER TABLE QRTZ_JOB ADD CONSTRAINT IDX_QRTZ_JOB_UNIQUE UNIQUE (JOB_IDX,JOB_CLASS);

COMMENT ON TABLE QRTZ_JOB IS '定时任务::任务配置表';
COMMENT ON COLUMN QRTZ_JOB.ID IS '主键';
COMMENT ON COLUMN QRTZ_JOB.APPLICATION IS '调度名称/应用名称';
COMMENT ON COLUMN QRTZ_JOB.STATE IS '任务状态 传入_默认INIT(EXECUTING.执行中 PAUSED.暂停 COMPLETE.完成 ERROR.异常 INIT.初始化/未启动）';
-- COMMENT ON COLUMN QRTZ_JOB.JOB_IDX IS '任务/触发器标签';
COMMENT ON COLUMN QRTZ_JOB.JOB_CLASS IS '任务全类名';
COMMENT ON COLUMN QRTZ_JOB.JOB_DATA IS '任务数据';
COMMENT ON COLUMN QRTZ_JOB.JOB_DESCRIPTION IS '任务描述';
COMMENT ON COLUMN QRTZ_JOB.update_time IS '更新时间';

-- QRTZ_EXECUTE
CREATE TABLE QRTZ_EXECUTE(
  ID NUMBER(18,0),
  PID NUMBER(18,0) NOT NULL,
--  EXECUTE_IDX NUMBER(10,0) NOT NULL,
  JOB_TYPE VARCHAR2(8) NOT NULL,
  STATE VARCHAR2(10) NOT NULL,
  CRON VARCHAR2(50),
  ZONE_ID VARCHAR2(50),
  REPEAT_COUNT NUMBER(10,0),
  REPEAT_INTERVAL NUMBER(10,0),
  TIME_TRIGGERED NUMBER(18,0) DEFAULT -1,
  PREV_FIRE_TIME NUMBER(18,0) DEFAULT -1,
  NEXT_FIRE_TIME NUMBER(18,0),
  HOST_IP VARCHAR2(50) NOT NULL,
  HOST_NAME VARCHAR2(80) NOT NULL,
  START_TIME NUMBER(18,0) NOT NULL,
  END_TIME NUMBER(18,0) DEFAULT -1,
  PRIMARY KEY (ID)
);

-- ALTER TABLE QRTZ_EXECUTE ADD CONSTRAINT IDX_QRTZ_EXECUTE_UNIQUE UNIQUE (PID,EXECUTE_IDX);
create INDEX QRTZ_EXECUTE_PID_IDX on QRTZ_EXECUTE (PID);

COMMENT ON TABLE QRTZ_EXECUTE IS '定时任务::执行配置表';
COMMENT ON COLUMN QRTZ_EXECUTE.ID IS '主键';
COMMENT ON COLUMN QRTZ_EXECUTE.PID IS '关联任务(QRTZ_JOB::ID)';
COMMENT ON COLUMN QRTZ_EXECUTE.JOB_TYPE IS '任务类型';
COMMENT ON COLUMN QRTZ_EXECUTE.STATE IS '任务状态 传入_默认INIT(EXECUTING.执行中 PAUSED.暂停 COMPLETE.完成 ERROR.异常 INIT.初始化/未启动）';
COMMENT ON COLUMN QRTZ_EXECUTE.CRON IS 'CRON:cron表达式';
COMMENT ON COLUMN QRTZ_EXECUTE.ZONE_ID IS 'CRON:时区';
COMMENT ON COLUMN QRTZ_EXECUTE.REPEAT_COUNT IS 'SIMPLE:重复/执行次数';
COMMENT ON COLUMN QRTZ_EXECUTE.REPEAT_INTERVAL IS 'SIMPLE:执行时间间隔';
COMMENT ON COLUMN QRTZ_EXECUTE.TIME_TRIGGERED IS 'SIMPLE:已執行次數，儅REPEAT_COUNT>時才會被統計';
COMMENT ON COLUMN QRTZ_EXECUTE.PREV_FIRE_TIME IS '上一次执行时间';
COMMENT ON COLUMN QRTZ_EXECUTE.NEXT_FIRE_TIME IS '下一次执行时间';
COMMENT ON COLUMN QRTZ_EXECUTE.HOST_IP IS '最后操作:执行机器地址';
COMMENT ON COLUMN QRTZ_EXECUTE.HOST_NAME IS '最后操作:执行机器名称';
COMMENT ON COLUMN QRTZ_EXECUTE.START_TIME IS '任务开始时间';
COMMENT ON COLUMN QRTZ_EXECUTE.END_TIME IS '任务结束时间,<1时没有结束时间';
