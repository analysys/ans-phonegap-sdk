package com.analysys.PhoneGapSDK;

import android.app.Application;

import com.analysys.AnalysysAgent;
import com.analysys.AnalysysConfig;
import com.analysys.EncryptEnum;

public class AnalysysApplication extends Application {
    public static final String APP_KEY = "2709692586aa3e42";
    public static final String UPLOAD_URL = "https://arkpaastest.analysys.cn:4089";

    @Override
    public void onCreate() {
        super.onCreate();
        AnalysysAgent.setDebugMode(this, 2);
        //  设置 debug 模式，值：0、1、2
        AnalysysConfig config = new AnalysysConfig();
        // 设置key(目前使用电商demo的key)
        config.setAppKey(APP_KEY);
        // 设置渠道
        config.setChannel("AnalsysyDemo");
        // 设置追踪新用户的首次属性
        config.setAutoProfile(true);
        // 设置使用AES加密
        config.setEncryptType(EncryptEnum.AES);
        // 设置服务器时间校验
        config.setAllowTimeCheck(true);
        // 时间最大允许偏差为5分钟
        config.setMaxDiffTimeInterval(5 * 60);
        // 开启渠道归因
        config.setAutoInstallation(true);
        // 热图数据采集（默认关闭）
        config.setAutoHeatMap(false);
        // pageView自动上报总开关（默认开启）
        config.setAutoTrackPageView(false);
        // fragment-pageView自动上报开关（默认关闭）
        config.setAutoTrackFragmentPageView(false);
        // 点击自动上报开关（默认关闭）
        config.setAutoTrackClick(false);
        config.setAutoTrackCrash(false);
        config.setAutoTrackDeviceId(true);
        // 初始化
        AnalysysAgent.init(this, config);
        AnalysysAgent.setUploadNetworkType(AnalysysAgent.AnalysysNetworkType.AnalysysNetworkALL);
        // 设置数据上传/更新地址
        AnalysysAgent.setUploadURL(this, UPLOAD_URL);
    }
}
