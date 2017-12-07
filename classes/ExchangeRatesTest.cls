/*
*   This is Unit test is for ExchangeRate class. It uses mock class
*   to simulate http://api.fixer.io behaviour
*   Created date : 07/12/2017
*   Author: Attiq Ur-Rehman
* 
*/

@isTest
public class ExchangeRatesTest {
    
		
    // normal flow: results willl be saved in platform cache
    
    	@isTest static void test_ExchangeRates() {
            
            
            ExchangeRateMockTest mock = new ExchangeRateMockTest('{"base":"USD","date":"2017-12-06","rates":{"EUR":1.222,"AUD":1.5565,"BGN":1.9558,"BRL":3.8193,"CAD":1.4963,"CHF":1.1678,"CNY":7.8169,"CZK":25.636,"DKK":7.4421,"GBP":0.88335,"HKD":9.2323,"HRK":7.5463,"HUF":314.45,"IDR":16007.0,"ILS":4.1519,"INR":76.243,"JPY":132.52,"KRW":1291.5,"MXN":22.203,"MYR":4.816,"NOK":9.7575,"NZD":1.7141,"PHP":59.891,"PLN":4.2142,"RON":4.632,"RUB":69.791,"SEK":9.9265,"SGD":1.5925,"THB":38.559,"TRY":4.5489,"USD":1.1817,"ZAR":15.985}}', 202);
            
            Test.setMock(HttpCalloutMock.class, mock);
           
            Exchange_Rate__c exRecords=new Exchange_Rate__c();
            exRecords.Base_Currency__c='USD';
            exRecords.Rate__c=1.10;
            exRecords.forList__c=true;
            exRecords.To_Currency__c='GBP';
            
            INSERT exRecords;
      
            // set platform cache named 'CurrencyCache' in setup.
            Cache.Org.put('local.CurrencyCache.Rates', exRecords);
           
            Test.startTest();
            ExchangeRates exRates=new ExchangeRates();
            exRates.init();
            
            List<Exchange_Rate__c> listRatesTotal=[SELECT Base_Currency__c from Exchange_Rate__c];
            // we should have only 1 currency returned.
            System.assertEquals(listRatesTotal.size(), 1);
            Test.stopTest();
            
			            
            
        }
    //test if platform cache doesn't return any results
    
    @isTest static void test_ExchangeRates_NullValues() {
            
            ExchangeRateMockTest mock = new ExchangeRateMockTest('{"base":"USD","date":"2017-12-06","rates":{"EUR":1.222,"AUD":1.5565,"BGN":1.9558,"BRL":3.8193,"CAD":1.4963,"CHF":1.1678,"CNY":7.8169,"CZK":25.636,"DKK":7.4421,"GBP":0.88335,"HKD":9.2323,"HRK":7.5463,"HUF":314.45,"IDR":16007.0,"ILS":4.1519,"INR":76.243,"JPY":132.52,"KRW":1291.5,"MXN":22.203,"MYR":4.816,"NOK":9.7575,"NZD":1.7141,"PHP":59.891,"PLN":4.2142,"RON":4.632,"RUB":69.791,"SEK":9.9265,"SGD":1.5925,"THB":38.559,"TRY":4.5489,"USD":1.1817,"ZAR":15.985}}', 202);
            
            Test.setMock(HttpCalloutMock.class, mock);
          
            List<Exchange_Rate__c> listRates=new List<Exchange_Rate__c>();
            Exchange_Rate__c exRecords=new Exchange_Rate__c();
            exRecords.Base_Currency__c='USD';
            exRecords.Rate__c=1.10;
            exRecords.forList__c=true;
            exRecords.To_Currency__c='GBP';
            
            INSERT exRecords;
            
            listRates.add(exRecords);
              
            // set platform cache named 'CurrencyCache' in setup.
            Cache.Org.put('local.CurrencyCache.Rates', exRecords);
            
            Test.startTest();
            RateLib.baseCurrencies='YYY';
            ExchangeRates exRates=new ExchangeRates();
           
            exRates.init();
            
        	// cache should return null, hence checking assert.
            Exchange_Rate__c[] rates = (Exchange_Rate__c[])Cache.Org.get(
            RateLib.cacheName+'Rates');
            System.assertEquals( rates, null);
            Test.stopTest();
            
            
            
        }
    

}