package AnalysysPlugin;

import android.content.Context;
import android.text.TextUtils;
import android.util.Log;
import com.analysys.AnalysysAgent;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaInterface;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CordovaWebView;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/**
 * @Copyright © 2018 EGuan Inc. All rights reserved.
 * @Description: TODO
 * @Version: 1.0
 * @Create: 2018/8/28 15:35
 * @Author: Wang-X-C
 */
public class AnalysysPlugin extends CordovaPlugin {
  
  Context context;
  String TAG = "analysys";

  @Override
  public void initialize(CordovaInterface cordova, CordovaWebView webView) {
    super.initialize(cordova, webView);
    this.context = cordova.getActivity().getApplicationContext();
  }

  @Override
  public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {

    Log.i(TAG, "ActionName：" + action);

    if (TextUtils.isEmpty(action)) {
      return false;
    } else if (action.equals("identify")) {
      AnalysysAgent.identify(context, args.getString(0));
      return true;
    } else if (action.equals("alias")) {
      String aliasId = args.getString(0);
      String originalId = args.getString(1);
      AnalysysAgent.alias(context, aliasId, originalId);
      return true;
    } else if (action.equals("reset")) {
      AnalysysAgent.reset(context);
      return true;
    } else if (action.equals("profileSet")) {
      AnalysysAgent.profileSet(context, toMap(args.getString(0)));
      return true;
    } else if (action.equals("profileSetOnce")) {
      AnalysysAgent.profileSetOnce(context, toMap(args.getString(0)));
      return true;
    } else if (action.equals("profileIncrement")) {
      AnalysysAgent.profileIncrement(context, toMapNumber(args.getString(0)));
      return true;
    } else if (action.equals("profileAppend")) {
      AnalysysAgent.profileAppend(context, toMap(args.getString(0)));
      return true;
    } else if (action.equals("profileUnset")) {
      AnalysysAgent.profileUnset(context, args.getString(0));
      return true;
    } else if (action.equals("profileDelete")) {
      AnalysysAgent.profileDelete(context);
      return true;
    } else if (action.equals("registerSuperProperty")) {
      AnalysysAgent.registerSuperProperty(context, args.getString(0), args.getString(1));
      return true;
    } else if (action.equals("registerSuperProperties")) {
      AnalysysAgent.registerSuperProperties(context, toMap(args.getString(0)));
      return true;
    } else if (action.equals("unRegisterSuperProperty")) {
      AnalysysAgent.unRegisterSuperProperty(context, args.getString(0));
      return true;
    } else if (action.equals("clearSuperProperties")) {
      AnalysysAgent.clearSuperProperties(context);
      return true;
    } else if (action.equals("getSuperProperty")) {
      AnalysysAgent.getSuperProperty(context, args.toString());
      return true;
    } else if (action.equals("getSuperProperties")) {
      AnalysysAgent.getSuperProperties(context);
      return true;
    } else if (action.equals("track")) {
      int length = args.length();
      if (length < 2) {
        AnalysysAgent.track(context, args.getString(0));
      } else {
        Map<String, Object> map = toMap(args.getString(1));
        AnalysysAgent.track(context, args.getString(0), map);
      }
      return true;
    } else if (action.equals("pageView")) {
      int length = args.length();
      if (length < 2) {
        AnalysysAgent.pageView(context, args.getString(0));
      } else {
        Map<String, Object> map = toMap(args.getString(1));
        AnalysysAgent.pageView(context, args.getString(0), map);
      }
      return true;
    }
    return false;
  }

  private Map<String, Object> toMap(String jsonStr) {
    Map<String, Object> result = new HashMap<String, Object>();
    try {
      JSONObject job = new JSONObject(jsonStr);
      Iterator<String> keys = job.keys();
      String key = null;
      Object value = null;
      while (keys.hasNext()) {
        key = keys.next();
        value = job.get(key);
        result.put(key, value);
      }
    } catch (JSONException e) {
      e.printStackTrace();
    }
    return result;
  }

  private Map<String, Number> toMapNumber(String jsonStr) {
    Map<String, Number> result = new HashMap<String, Number>();
    try {
      JSONObject job = new JSONObject(jsonStr);
      Iterator<String> keys = job.keys();
      String key = null;
      Number number = null;
      while (keys.hasNext()) {
        key = keys.next();
        Object value = job.get(key);
        if (value instanceof Integer) {
          number = (int) value;
        } else if (value instanceof Long) {
          number = (long) value;
        } else if (value instanceof Double) {
          number = (double) value;
        } else if (value instanceof Float) {
          number = (float) value;
        }
        result.put(key, number);
      }
    } catch (JSONException e) {
      e.printStackTrace();
    }
    return result;
  }
}
