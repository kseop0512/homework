package com.homework.controller;

import com.google.gson.*;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Iterator;

@Controller
public class HomeworkController {

    @RequestMapping(value = "/homework2")
    public String homework2() {
        return "homework2";
    }

    @RequestMapping(value = "/homework3")
    public String homework3() {
        return "homework3";
    }

    @ResponseBody
    @RequestMapping(value = "/getCalcResult", produces="application/json;charset=utf-8")
    public String getCalcResult(@RequestBody String str) {

        int[] pi;
        int[] ni;
        int[][] arr;
        JsonParser parser = new JsonParser();
        JsonElement element = parser.parse(str);
        int amount = element.getAsJsonObject().get("amount").getAsInt();
        int count = element.getAsJsonObject().get("count").getAsInt();
        JsonObject list =  element.getAsJsonObject().get("list").getAsJsonObject();

        arr = new int [count+1][amount+1];
        pi = new int[count+1];
        ni = new int[count+1];
        arr[0][0] = 1;
        int cnt = 1;
        for (String s : list.keySet()) {
            arr[cnt][0] = 1;
            String b = s.toString();
            pi[cnt] = Integer.parseInt(b);
            ni[cnt] = Integer.parseInt(String.valueOf(list.get(b)));

            cnt++;
        }

        for(int i=1; i<=count; i++) {
            for(int j=1; j<=amount; j++) {
                // 이전 동전이 만든 잔돈과
                // 내가 만들 잔돈을 더해 주면
                // 잔돈을 만들수 있는 케이스가 합쳐진다.
                for(int k=0; k<=ni[i]; k++) {
                    if(pi[i]*k > j) break;
                    arr[i][j] += arr[i-1][j-pi[i]*k];
                }
            }
        }

        return new Gson().toJson(arr[count][amount]);
    }
}
