//
//  PKInterfaceDefine.h
//  PKeeper
//
//  Created by mylonly on 15/3/5.
//  Copyright (c) 2015年 www.mylonly.com. All rights reserved.
//

#ifndef PKeeper_PKInterfaceDefine_h
#define PKeeper_PKInterfaceDefine_h

#define UPYUNIMAGEPATH(savekey) [NSString stringWithFormat:@"http://pk-image.b0.upaiyun.com/%@",savekey]

#define UPYUNVIDEOPATH(savekey) [NSString stringWithFormat:@"http://pk-video.b0.upaiyun.com/%@",savekey]

#define HOST @"http://121.40.150.229:8088/"

#define BATCHID @"batch_id"

//登陆
#define LOGIN STRFORMAT(@"%@/chkplatform/front/logindao.do",HOST)

//注册
#define REGISTER STRFORMAT(@"%@/chkplatform/page/system/register.do",HOST)

//提交个人信息
#define SUBMIT_USERINFO STRFORMAT(@"%@/chkplatform/page/system/updateUser.do",HOST)

//获取鸡场信息
#define GET_CHICKENINFO STRFORMAT(@"%@/chkplatform/chickenfactroycontroller/getChickenFactoryInfoByUserId.do",HOST)

//提交鸡场信息
#define SUBMIT_CHICKENINFO STRFORMAT(@"%@/chkplatform/chickenfactroycontroller/saveChickenFactroyInfo.do",HOST)

//更新鸡场信息
#define UPDATE_CHICKENINFO STRFORMAT(@"%@/chkplatform/chickenfactroycontroller/updateCfactoryInfo.do",HOST)

//新增一个批次
#define CREATE_ONE_BATCH STRFORMAT(@"%@/chkplatform/chickenbatchnum/saveChickenBatchNum.do",HOST)

//获取所有的批次信息
#define GET_BATCHLIST STRFORMAT(@"%@/chkplatform/chickenbatchnum/getChickenBatchNumByCid.do",HOST)

//获取当前所在阶段
#define GET_CURRENT_STAGE STRFORMAT(@"%@/chkplatform/chickenbatchnum/getstagebybatchnum.do",HOST)

//获取第一阶段的养殖记录
#define GET_FIRSTSTAGERECORD_LIST STRFORMAT(@"%@/chkplatform/everydayrecord/getFirstStageRecord.do",HOST)

//获取第二阶段的养殖记录
#define GET_SECONDSTAGERECORD_LIST STRFORMAT(@"%@/chkplatform/everydayrecord/getSecondStageRecord.do",HOST)

//获取第三阶段的养殖记录
#define GET_THIRDSTAGERECORD_LIST STRFORMAT(@"%@/chkplatform/everydayrecord/getThirdStageRecord.do",HOST)

//获取每日标准流程
#define GET_STANDARDFLOW STRFORMAT(@"%@/chkplatform/standarflow/getStandarByStageAndDay.do",HOST)

//提交第一阶段养殖记录
#define SUBMIT_FIRSTSTAGERECOD STRFORMAT(@"%@/chkplatform/everydayrecord/saveFirstStageDayRecord.do",HOST)

//提交第二阶段养殖记录
#define SUBMIT_SECONDSTAGERECOD STRFORMAT(@"%@/chkplatform/everydayrecord/saveSecondStageDayRecord.do",HOST)

//提交第三阶段养殖记录
#define SUBMIT_THIRDSTAGERECOD STRFORMAT(@"%@/chkplatform/everydayrecord/saveThirdStageDayRecord.do",HOST)

//获取疾病报告列表
#define GET_SICKREPORT_LIST STRFORMAT(@"%@/chkplatform/illreport/getIllReport.do",HOST)

//提交疾病报告
#define SUBMIT_SICKREPORT STRFORMAT(@"%@/chkplatform/illreport/saveIllReport.do",HOST)

//最新行业知识
#define GET_NEWS_LIST STRFORMAT(@"%@/chkplatform/page/manager/getDocuments.do",HOST)

//验证当天报告是否提交
#define CHECKFARMRECORD STRFORMAT(@"%@/chkplatform/everydayrecord/validRecordSubmit.do",HOST)

//获取当前用户未读的已收到回复的疾病报告
#define GETNUMOFREPORTBYREPLY STRFORMAT(@"%@/chkplatform/illreport/getNewReplyIllReportCount.do",HOST)

//设置报告已读
#define SETREPORTREAD STRFORMAT(@"%@/chkplatform/illreport/readIllReport.do",HOST)

//最新行业知识web路径
#define NEWS_URL(DOCID) STRFORMAT(@"%@/chkplatform/manager/showDetailByDocid.do?docid=%@",HOST,DOCID)
#endif
