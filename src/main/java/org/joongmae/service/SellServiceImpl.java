package org.joongmae.service;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.joongmae.domain.AlarmVO;
import org.joongmae.domain.BuyVO;
import org.joongmae.domain.SellVO;
import org.joongmae.mapper.SellMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class SellServiceImpl implements SellService {

	@Setter(onMethod_ = @Autowired)
	private SellMapper mapper;
	
	@Override
	public SellVO detail(int sellNo) {
		
		return mapper.detail(sellNo);
	}

	@Override
	public int register(SellVO sell) {
		
		return mapper.register(sell);
	}

	@Override
	public int modify(SellVO sell) {
		
		return mapper.modify(sell);
	}

	@Override
	public int delete(int sellNo) {
		
		return mapper.delete(sellNo);
	}

	@Override
	public List<SellVO> list() {
		
		return mapper.list();
	}

	@Override
	public int registerAlarm(SellVO sell) {
		 
		ArrayList<List<Object>> result = new ArrayList<>();
		
		List<BuyVO> buyList = mapper.temp(sell.getId());
		
		String sellKeywords[] = new String[3];
		sellKeywords[0] = sell.getKeyword1();
		sellKeywords[1] = sell.getKeyword2();
		sellKeywords[2] = sell.getKeyword3();
		
		for (int index = 0; index < buyList.size(); index++) {
			
			String buyKeywords[] = new String[3];
			
			buyKeywords[0] = buyList.get(index).getKeyword1();
			buyKeywords[1] = buyList.get(index).getKeyword2();
			buyKeywords[2] = buyList.get(index).getKeyword3();
			
			for (int i = 0; i < 3; i++) {
				for (int j = i + 1; j < 3; j++) {
					if (sellKeywords[i].equals(sellKeywords[j])) {
						sellKeywords[j] = "";
					}
					if (buyKeywords[i].equals(buyKeywords[j])) {
						buyKeywords[j] = "";
					}
				}
			}
			
			for (int i = 0; i < 3; i++) {
				System.out.println("sellKeywords["+ i + "] : " + sellKeywords[i]);
			}
			
			for (int i = 0; i < 3; i++) {
				System.out.println("buyKeywords["+ i + "] : " + buyKeywords[i]);
			}
			
			int count = 0;
			
			for (int i = 0; i < 3; i++) {
				for (int j = 0; j < 3; j++) {
					if (sellKeywords[i].equals(buyKeywords[j])) {
						count++;
					}
				}
			}
			
			List<Object> list = new ArrayList<>();
			
			list.add(count);
			list.add(buyList.get(index).getId());
			list.add(buyList.get(index).getBuyNo());
			
			result.add(list);
		}
		
		int point = 3;
		int count = 0;
		while(true){
			if (point == 0) {
				break;
			} else {
				for (int i = 0; i < result.size(); i++) {
					if (count == 10) {
						break;
					} else if (result.get(i).get(0).equals(point)) {
						AlarmVO alarm = new AlarmVO(0, (String)result.get(i).get(1), (Integer)result.get(i).get(2), sell.getId(), mapper.count(), "등록");
						System.out.println(alarm);
						mapper.registerAlarm(alarm);
						count++;
					}
				}
				point--;
			}
		}
		
		
		return 0;
	}

	@Override
	public int reRegister(int sellNo) {
		
		mapper.delete(sellNo);
		return mapper.reRegister(sellNo);
	}

}
