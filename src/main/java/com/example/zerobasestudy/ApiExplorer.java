package com.example.zerobasestudy;

import com.example.zerobasestudy.WifiService;

import java.io.IOException;
import java.sql.SQLException;

public class ApiExplorer {
    public static void main(String[] args) throws IOException, SQLException {
        WifiService wifiService = new WifiService();
        wifiService.saveWifiData();
        wifiService.getWifiInfos();
    }
}