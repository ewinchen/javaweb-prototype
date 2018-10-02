package com.esquel.gek.prototype.service;

import java.util.List;
import java.util.Map;

public interface DefaultService {

    Map<String, Object> getGkNumInfo();

    List<Map<String, Object>> getJobNum();

    List<Map<String, Object>> getPackDetail();

    List<Map<String, Object>> getPpoNum();
}
