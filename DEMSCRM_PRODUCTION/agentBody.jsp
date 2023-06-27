<%@page import="com.smartnapp.agentportal.util.XSSUtils"%>
<%@page import="com.smartonapp.encryption.PasswordUtilsCRMNext"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>

<!-- Disable cache  -->
<%
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); 
response.setHeader("Pragma","no-cache"); 
response.setDateHeader("Expires", -1);
response.setHeader("X-Frame-Options", "SAMEORIGIN");
%>
<!-- End -->

<html>
	<head>
	
		<!-- Disable cache  -->
		<meta http-equiv="Pragma" content="no-cache"/>
		<meta http-equiv="Cache-Control" content="no-cache"/>
		<meta http-equiv="Cache-Control" content="no-store">
		<meta http-equiv="Expires" content="-1">
		<!-- End -->
		
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Agent Portal</title>
		 
		<style type="text/css">
		
		.txtbox{
		border-radius: 15px;
		width: 90%;
		height: 25px;
		padding-left: 5px;
		padding-right: 15px;
		margin-bottom: 5px;
		margin-top: 8px;
		box-shadow: 0 0 5px grey;
		border: 1px solid grey;
		color: #4f4f4f;
		font-size: 16px;
		}
		
		table#tablehistory {
			border-collapse: collapse;
		}
		
		#tablehistory table, #tablehistory td, #tablehistory th {
    		border: 1px solid black;
		}
		
		#tablehistory th {
    		height: 30px;
		}
		
		.errorborder {
			border: 1px solid red;
		}
		
		.scriptlinks {
			margin-left: 50px;
		}
		
		#processTable select {
			width: 200px;
		}
		
		div.main{
				/*width: 250px;
				float:center;*/
				padding: 7px 20px 9px;
				background-color: white;
				/*border: 3px solid grey;*/
				/*box-shadow: 0 0 10px;
				border-radius: 2px;*/
				font-size: 10px;
				}
		</style>
		
		<script type="text/javascript">
		var secret = "ABCDJHBFDJIBEFIBHEFEFIBHJEF12345679808961J";
		var off =true;
		 var SUBPROCESSID_mk="";
		 var SUBPROCESSNAME_mk ="";
		 var campname="";
		 var hold_dur="";
		 var wrap_dur="";
		 var talk_dur="";
		 
		 var hold_dur_time="";
		 var wrap_dur_time="";
		 var talk_dur_time="";
		 var yonowindow = "";
		var Scrt="";
		var obj="";
		var cust="";
		var ssokey="";
		var newwindow;
		var newURL ="";
		var timer = '';
	 	var call_start="";
	 	var call_end="";
		var main_url="https://10.82.30.27:5004/CTI_APP/"; 
	var dail_no="";
	
	//	var main_url="https://10.82.12.95:443/CTI_APP/";
//	var main_url="https://SBIVADOBTS1:443/CTI_APP/";
	var customer_ID="";
	var service_ID="";
	var delinquency_ID="";
	 var Account_ID=""; 
	 var authdata="";
	 var sessiondata="";
	 var username="";
	    
		 var ff=false;
		 var tt=true;
        function showWindow(path){
            	url = path;
              newwindow=window.open(url,'name','height=1100,width=1300,location=no,scrollbars=yes,resizable=yes');
            if (window.focus) {newwindow.focus()}
		}									  
		
		function closeWindow(){
           newwindow.close();
           localStorage.clear();
           yonowindow = "";
		}
		
		var yonowindow = "";
	  	var apidata=false;
		var check_ready = false; //manjit
		var interval='';
		var scriptWindow = "";
		var logoutFalg = false;
		
		var jsonDisp = "";
	    var dispJsonArray = "";
	    
	    var callID = 0;
		var customerID = 0;
		var serviceName = "";
		var serviceID = 0;
		var dialNumber = 0;
		var tableName = "";
		
	    var agentIndex = 0;
		var autoRecording = 0;
		var fileName = "";
		var mediaType = 0;
		var recordingIndex = 0;
		var recordingRate = 0;
		var recordingSeq = 0;
		var recordingState = 0;
		var recordingStoreID = 0;
		
		var CustomerDetails = "";
		var LOBDetails = "";
		var AgentScriptDetails = "";
		var labelMapDetails = "";
		var orderMapDetails = "";
		var subProcessDetails = "";
		var processDetails = "";
		
		// Added on 29-07-2017 OCAS
		var ocasProcessDetails = "";
		var ocasDetails = "";
		
		// Added on 24-03-2017 LCS
		var lcsDetails = "";
		
		var kvPairXml = "";
		var dispositionXml = "";
		var callbackXml = "";
		var subDispXml = "";
		var portalURLArray = [];
		
		var snoozeValue = 0;
		
		var disposeTime = 0;
		var autoDisposeTimer = "";
		var agentRefreshTime = 0;
		var autoDisposeTimePerc = 0;
		var autoDisposeAlertTime = 0;
		
		var sequenceNumber = "";
		
		// Added on 25-03-2017
		var isActive = false;
		
		window.onbeforeunload = function() {
			return "";
		};
		
		// Added on 11-07-0217
    	var jsLogPath = "";
    	var jsLogFileName = "";
    	var writeFile = "";
		// Ended
		
		var sessionAgentName = '<%=session.getAttribute("agentName") != null ? XSSUtils.cleanXSS(session.getAttribute("agentName").toString()) : ""%>';
		if(sessionAgentName != "") {
			window.location.href = "./4XXerror.jsp";
		}
		
		$("#Papldatetime").click(function(){
			  var date  = new Date();
			  var count= "15";//document.getElementById("count").value;
			  count=parseInt(count);
				 date.setDate(date.getDate() + count);
			  		   
			 
			 $("#Papldatetime").datetimepicker({
				 minDate: 0,
				  step: 15,
				 format: 'Y-m-d H:i',
				 maxDate:date
				  
			 });
		});
		function getKVPairList1(flag) {
			var portals = "";
			var stringportals = "";
			var primaryURL = "";
			var backupURL = "";
			$.ajax({
		        type: "POST",
		        url: "portal",
		        data: "opcode=kvpair1&appName=CRM",
		        dataType: 'json',
		        //async: false,
		        success: function(response) {
		        	responseJSON = JSON.parse(JSON.stringify(response));
		        	if(responseJSON != null && responseJSON != "" && typeof responseJSON !== "undefined") {
		        		var kvPairJson = responseJSON["kvPairList"];
			        	var dispParseJson = responseJSON["dispDetails"];
			        	var subDispParseJson = responseJSON["subDispDetails"];
			        	var cbParseJson = responseJSON["callbackDetails"];
			        	var portalkey = "";
			        
			        	if(dispParseJson != null && dispParseJson["dispStatus"] == "Success" && dispParseJson["dispositionXml"] != null) {
			        		//dispositionXml = dispParseJson["dispositionXml"];
			        		dispositionXml = null; // Added on 16-11-2017
			        	}
			        	if(subDispParseJson != null && subDispParseJson["subDispStatus"] == "Success" && subDispParseJson["subDispositionXml"] != null) {
			        		subDispXml = subDispParseJson["subDispositionXml"];
			        		//console.log("subDispXml:-"+subDispXml);
			        	}
			        	if(cbParseJson != null && cbParseJson["callbackStatus"] == "Success" && cbParseJson["callbackXml"] != null) {
			        		callbackXml = cbParseJson["callbackXml"];
			        	}
			        	if(kvPairJson != null && kvPairJson["kvPairStatus"] == "Success" && kvPairJson["kvpXml"] != null) {
			        		kvPairXml = kvPairJson["kvpXml"];
			        		portalkey = kvPairJson["portalkey"];
			        		agentRefreshTime = kvPairJson["refreshTime"];
			        		autoDisposeTimePerc = kvPairJson["autoDisposeTimePerc"];
			        		// Added on 11-07-0217
			        		jsLogPath = kvPairJson["jsLogPath"];
			        		jsLogFileName = kvPairJson["jsLogFileName"];
			        	} 
			        	
			        	var item = {};
			        	var regExp = new RegExp(portalkey);
			        	if(kvPairXml != null) {
							var kvPairXmlDoc = $.parseXML(kvPairXml);
						    $kvxml = $(kvPairXmlDoc);
							$kvxml.find("KVPLIST").each(function() {
								if(regExp.test($(this).find("KEY").text())) {
									item[$(this).find("KEY").text()] = $(this).find("VALUE").text();
								}
							});
							stringportals = JSON.stringify(item);
						}
		        	} 
		        },
		        error: function(e){
		        }
			}); 
			return stringportals;
		}
		
		function getRefreshTime(refreshTimeFlag) {
			if(refreshTimeFlag) {
				return agentRefreshTime;
			}
		}	
		
		function getdispositios(jsonDisposition) {
	    	var jsonDispParse = JSON.parse(jsonDisposition);
	    	if(jsonDispParse != null && jsonDispParse != "" && jsonDispParse != "undefined") {
	    		jsonDisp = jsonDispParse["jsonDispositions"];
		    	dispJsonArray = [];
		    	for(var k in jsonDisp) {
		    		dispJsonArray.push(k);
		    	}
		    	dispositios(dispJsonArray);
	    	}
        }
		
		
		
		
		
		// Added on 15-05-2017
		function dispositios(dispJsonArray) {
			var dispXmlDoc = "";
			$("#disposition").html("");
			var dispoptionValues = '<option value="">-- Select --</option>';
			if(dispositionXml != null) {
				dispXmlDoc = $.parseXML(dispositionXml);
				$(dispXmlDoc).find("ROW").each(function() {
					if($(this).find("DISPLAYFLAG").text() == 1) {
						dispoptionValues += '<option id="'+ $(this).find("DISPOSITIONID").text() +'" data="'+ $(this).find("DISPOSITIONCODE").text() +'" value="'+ $(this).find("DISPOSITIONNAME").text() +'">'+ $(this).find("DISPOSITIONNAME").text() +'</option>';
					}
				});
			} else { // Added on 16-11-2017
				dispoptionValues += '<option id="159" data="THPY" value="Third Party">Third Party</option>';
			}
			$("#disposition").append(dispoptionValues);
		}
		
		function getrecordstates(jsonRecordStates) {
			var jsonRecordParse = JSON.parse(jsonRecordStates);
			if(jsonRecordParse != null && jsonRecordParse != "" && typeof jsonRecordParse !== "undefined") {
				var jsonRecords = jsonRecordParse["jsonRecordStates"];
				agentIndex = jsonRecords["agentIndex"];
				autoRecording = jsonRecords["autoRecording"];
				fileName = jsonRecords["fileName"];
				mediaType = jsonRecords["mediaType"];
				recordingIndex = jsonRecords["recordingIndex"];
				recordingRate = jsonRecords["recordingRate"];
				recordingSeq = jsonRecords["recordingSeq"];
				recordingState = jsonRecords["recordingState"];
				recordingStoreID = jsonRecords["recordingStoreId"];
			}
		}
		
		function languageList() {
			$("#language").html("");
			var languageOptions = "";
			var languageList = "";
			if(kvPairXml != null) {
				var kvPairXmlDoc = $.parseXML(kvPairXml);
			    $kvxml = $(kvPairXmlDoc);
				$kvxml.find("KVPLIST").each(function() {
					if($(this).find("KEY").text() == "LANGUAGELIST") {
						languageList = $(this).find("VALUE").text();
					}
				});
				var langSplitArray = languageList.split(",");
				var lanLength = langSplitArray.length;
				for (var i = 0; i < lanLength; i++) {
					languageOptions += '<option value="' + langSplitArray[i] + '" ' + (langSplitArray[i] == "Hindi" ? "selected" : "") +'>' + langSplitArray[i] + '</option>'
				}
				$("#language").append(languageOptions);
			}
		}
		
	
		
		// Added on 04-04-2017
		function getSequenceNumber(seqJsonObject) {
			var callID = 0;
			var isGenerated = false;
			var jsonSeqParse = JSON.parse(seqJsonObject);
			if(jsonSeqParse != null && jsonSeqParse != "" && typeof jsonSeqParse !== "undefined") {
				callID = jsonSeqParse["callID"];
				jsonDisp = jsonSeqParse["jsonDispositions"];
				isGenerated = jsonSeqParse["isGenerated"];
		    	dispJsonArray = [];
		    	for(var k in jsonDisp) {
		    		dispJsonArray.push(k);
		    	}
		    	contactDispositios(dispJsonArray, "Not Contact");
			}
			isActive = isGenerated;
			if(isGenerated) {
				$.ajax({
			        type: "POST",
			        url: "portal",
			        data: "opcode=random&callID=" + callID,
			        async: false,
			        dataType: 'json',
			        success: function(response) {
			        	var responseJSON = JSON.parse(JSON.stringify(response));
			        	if(responseJSON != null && responseJSON != "") {
			        		sequenceNumber = responseJSON["sequenceNumber"];
							if(sequenceNumber.length != 20) {
			        			sequenceNumber = getAgainSequenceNumber(callID);
			        		}
			        	}
			        },
			        error: function(e){
			        }
				});
			}
			return sequenceNumber;
		}
		
		function getAgainSequenceNumber(callID) {
			var sequenceNum = "";
			$.ajax({
		        type: "POST",
		        url: "portal",
		        data: "opcode=random&callID=" + callID,
		        async: false,
		        dataType: 'json',
		        success: function(response) {
		        	var responseJSON = JSON.parse(JSON.stringify(response));
		        	if(responseJSON != null && responseJSON != "") {
		        		sequenceNum = responseJSON["sequenceNumber"];
		        	}
		        },
		        error: function(e){
		        }
			});
			return sequenceNum;
		}
		
		function clickYONOCRM(){
			
			
			$("#lobInfo").css("background-color", "#6f76cf");
			$("#callHistoryInfo").css("background-color", "#6f76cf");
			$("#agentScripts").css("background-color", "#6f76cf");
			
			$("#lcstabdata").show();
			$("#customerTable").hide();
			$("#processTable").hide();
			$("#historysearch").hide();
			$("#historydata").hide();
			$("#agentscriptslinks").hide();
			//$("#bottomdiv").hide();
			//$("#agentstatsinfo").hide();
		}
		
		 
		
		// Added on 15-05-2017
		function notContactDispositios(dispJsonArray, type) {
			var dispXmlDoc = "";
			$("#disposition").html("");
	    	var dispoptionValues = '<option value="">-- Select --</option>';
   			if(dispositionXml != null) {
   				dispXmlDoc = $.parseXML(dispositionXml);
   				$(dispXmlDoc).find("ROW").each(function() {
 					if($(this).find("DISPLAYFLAG").text() == 1 && $(this).find("DISPOSITIONSTATE").text().toLowerCase() == type.toLowerCase()) {
 						dispoptionValues += '<option id="'+ $(this).find("DISPOSITIONID").text() +'" data="'+ $(this).find("DISPOSITIONCODE").text() +'" value="'+ $(this).find("DISPOSITIONNAME").text() +'">'+ $(this).find("DISPOSITIONNAME").text() +'</option>';
 					}
 				});
   	    	}
	    	$("#disposition").append(dispoptionValues);
		}
		 
		// Added on 15-05-2017
		function contactDispositios(dispJsonArray, type) {
			var dispXmlDoc = "";
			$("#disposition").html("");
	    	var dispoptionValues = '<option value="">-- Select --</option>';
   			if(dispositionXml != null) {
   				dispXmlDoc = $.parseXML(dispositionXml);
   				$(dispXmlDoc).find("ROW").each(function() {
 					if($(this).find("DISPLAYFLAG").text() == 1 && $(this).find("DISPOSITIONSTATE").text().toLowerCase() != type.toLowerCase()) {
 						dispoptionValues += '<option id="'+ $(this).find("DISPOSITIONID").text() +'" data="'+ $(this).find("DISPOSITIONCODE").text() +'" value="'+ $(this).find("DISPOSITIONNAME").text() +'">'+ $(this).find("DISPOSITIONNAME").text() +'</option>';
 					}
 				});
   	    	} else { // Added on 16-11-2017
				dispoptionValues += '<option id="159" data="THPY" value="Third Party">Third Party</option>';
			}
	    	$("#disposition").append(dispoptionValues);
		}
		
		// Added on 24-03-2017 LCS
		function getlcspage(lcsJsonObject) {
			$("#navigationtabs").show();
			$("#lcstabdata").html("");
			$("#navigationtabs").html("");
            var navtabs = '<ul id="navigation" class="navigation">' +
		    '<li><span id="customerInfo">Customer Information</span></li>' +
		    '<li><span id="lobInfo" data="' + processDetails["PROCESSID"] + '" style="">' + processDetails["PROCESSNAME"] + '</span></li>' +
		    '<li><span id="callHistoryInfo">Call History</span></li>' +
		    '<li><span id="agentScripts">Agent Scripting</span></li>';
		    
		    if(lcsDetails != null && lcsDetails != "" && typeof lcsDetails !== "undefined") {
		    	if(lcsDetails["lcsSubProcList"] != null && lcsDetails["lcsSubProcList"] != "" && typeof lcsDetails["lcsSubProcList"] !== "undefined") {
		    		var subProcArray = lcsDetails["lcsSubProcList"].split(",");
			    	for (var i = 0; i < subProcArray.length; i++) {
			    		//if(processDetails["PROCESSNAME"] == "DRA" && subProcessDetails["SUBPROCESSNAME"] == subProcArray[i]) {
					if(processDetails["PROCESSNAME"] == "DRA" && subProcessDetails["SUBPROCESSNAME"].toLowerCase().indexOf(subProcArray[i].toLowerCase()) >= 0) {
							navtabs = navtabs + '<li><span id="lcstab">LCS</span></li>';
							break;
						}
					}
		    	}
		    }
		    navtabs = navtabs + '<label id="subProcess" data="' + subProcessDetails["SUBPROCESSID"] + '">' + subProcessDetails["SUBPROCESSNAME"] + '</label>' +
			'</ul>';
			$("#navigationtabs").append(navtabs);
			
			if(CustomerDetails != null && CustomerDetails != "" && typeof CustomerDetails !== "undefined" ) {
				displayCustomerDetails(CustomerDetails); 
			}
			
			if(LOBDetails != null && LOBDetails != "" && typeof LOBDetails !== "undefined" ) {
				displayLOBDetails(LOBDetails);  
			}
			
			var lcsParsedJsonObjcet= JSON.parse(lcsJsonObject);
			if(lcsParsedJsonObjcet != null && lcsParsedJsonObjcet != "" && typeof lcsParsedJsonObjcet !== "undefined") {
				var resID = lcsParsedJsonObjcet["resID"];
				var resDateTime = lcsParsedJsonObjcet["resDateTime"];
				var responseCode = lcsParsedJsonObjcet["responseCode"];
				var responseDesc = lcsParsedJsonObjcet["responseDesc"];
				var tokenNo = lcsParsedJsonObjcet["tokenNo"];
				var lcsURL = lcsParsedJsonObjcet["lcsURL"];
				//lcsURL = lcsURL + "?requestID=" + resID + "&token=" + tokenNo;
				lcsURL = lcsURL + "?requestID=91325&token=" + tokenNo;
				if(responseCode == "C00001"  || responseCode == "c00001") {
	        		$("#lcstabdata").append('<iframe src="' + lcsURL + '" id="iframe" width="100%" style="border: 0;" height="400"></iframe>');
	        	} else {
	        		$("#lcstabdata").append("<h3 style='color: red; text-align:center; margin-top: 200px;'>" +
	        			responseCode + " - " + responseDesc +
        				"</h3>");
	        	}
			}
		}
		// Ended
		
		// Added on 29-07-2017 OCAS
		function getocaspage(ocasJsonObject) {
			$("#navigationtabs").show();
			var bucketType = "";
			var loanType = "";
			
			$("#lcstabdata").html("");
			$("#navigationtabs").html("");
            var navtabs = '<ul id="navigation" class="navigation">' +
		    '<li><span id="customerInfo">Customer Information</span></li>' +
		    '<li><span id="lobInfo" data="' + processDetails["PROCESSID"] + '" style="">' + processDetails["PROCESSNAME"] + '</span></li>' +
		    '<li><span id="callHistoryInfo">Call History</span></li>' +
		    '<li><span id="agentScripts">Agent Scripting</span></li>';
		    
		    if(ocasDetails != null && ocasDetails != "" && typeof ocasDetails !== "undefined") {
		    	if(ocasDetails["ocasStatus"] == "Success") {
			    	if(ocasDetails["ocasProcessList"] != null && ocasDetails["ocasProcessList"] != "" && typeof ocasDetails["ocasProcessList"] !== "undefined") {
			    		var ocasProcArray = ocasDetails["ocasProcessList"].split(",");
				    	for (var i = 0; i < ocasProcArray.length; i++) {
				    		if(processDetails["PROCESSNAME"] == ocasProcArray[i]) {
								navtabs = navtabs + '<li><span id="lcstab">OCAS</span></li>';
								break;
							}
						}
			    	}
		    	}
		    }
		    navtabs = navtabs + '<label id="subProcess" data="' + subProcessDetails["SUBPROCESSID"] + '">' + subProcessDetails["SUBPROCESSNAME"] + '</label>' +
			'</ul>';
			$("#navigationtabs").append(navtabs);
			
			if(CustomerDetails != null && CustomerDetails != "" && typeof CustomerDetails !== "undefined" ) {
				displayCustomerDetails(CustomerDetails); 
			}
			
			if(LOBDetails != null && LOBDetails != "" && typeof LOBDetails !== "undefined" ) {
				displayLOBDetails(LOBDetails);  
			}
			
			var ocasParsedJsonObjcet= JSON.parse(ocasJsonObject);
			if(ocasParsedJsonObjcet != null && ocasParsedJsonObjcet != "" && typeof ocasParsedJsonObjcet !== "undefined") {
				var loginRequestURL = ocasParsedJsonObjcet["loginRequestURL"];
				if(loginRequestURL != ""  && loginRequestURL != null  && typeof loginRequestURL !== "undefined") {
	        		$("#lcstabdata").append('<iframe src="' + loginRequestURL + '" id="iframe" width="100%" style="border: 0;" height="400"></iframe>');
	        	}
			}
		}
		// Ended
		
		function autodispose(isAutoDispose, autoDisposeTime) {
			if(isAutoDispose) {
				disposeTime = autoDisposeTime;
				autoDisposeAlertTime = (disposeTime * autoDisposeTimePerc)/100;
				autoDisposeTimer = setInterval(startDisposeTimer, 1000);
			}
		}
		function startDisposeTimer() {
			if( disposeTime >= 0 && disposeTime <= autoDisposeAlertTime) {
				$("#autodisposespan").css("display", "");
		 		$("#disposeTime").text(disposeTime);
			}
			if(disposeTime >= 0) {
				disposeTime--;
			}                                                                                                    
		}
		function stopDisposeTimer() {
			if(autoDisposeTimer != "" && autoDisposeTimer != null && typeof autoDisposeTimer !== "undefined") {
				$("#autodisposespan").css("display", "none");
				clearInterval(autoDisposeTimer);
			}
		}
		
		function getAgentStats(agentStatsFlag) {
			if(agentStatsFlag) {
				var agentName = $("#agentName").val();
				  $.ajax({
				       type: "POST",
				       url: "portal",
				       data: "opcode=agentstats&agentName=" + agentName,
				       dataType: 'json',
				       success: function(response) {
						   
					       	var responseJSON = JSON.parse(JSON.stringify(response));
					      	var statsDetails = responseJSON["AgentStatsDetails"];
					       	if(statsDetails["agentStatsStatus"] == "Success" && statsDetails != null) {
					        	 
					       	}
				       },
				       error: function(e){
				       }
				}); 
			}
		}
		
		function callbackValidation(jsonCallDispObject) {
			var cbflag = true;
			var jsonCallDispParse= "";
			
			var agentName = "";
			var agentID = "";
			var isDispose = false;
			
			var processID = 0;
			var subProcessID = 0;
			
			var agentRemarks = "";
	    	var dispositionID = 0;
	    	var dispositionCode = "";
	    	var disposition = "";
			var subDispositionID = 0;
			var subDispositionCode = "";
			var subDisposition = "";
	    	var callbackFlag = 0;
	    	var salesFlag = 0;
	    	var exclusionFlag = 0;
	    	var category = "";
	    	
	    	var callBackNumber = "";
			var callBackType = "";
			var callBackDateTime = "";
			var language = "";
			
			var date = "";
			var currDate = new Date();
			var dt = currDate.getDate();
		    var month = currDate.getMonth() + 1; 
		    var year = currDate.getFullYear();
		    if(dt < 10) {
		    	dt = '0' + dt;
			} 
			if(month < 10) {
			    month = '0' + month;
			}
			date = year + "-" + month + "-" + dt;
			
			var idleTime = 0;
			var talkTime = 0;
			var wrapTime = 0;
			var holdTime = 0;
			var previewTime = 0;
			var callStartTime = "";
			var callEndTime = "";
			
			var subdispoptioncount = 0;
			var callbackTypeCount = 0;
			var dispositons = "";
			var stringdisp= "";
			
			// Added on 25-03-2017
			var contactFlag = false;
			var notContactFlag = false;
			
			if(jsonCallDispObject != null && jsonCallDispObject != "" && typeof jsonCallDispObject !== "undefined") {
    			jsonCallDispParse = JSON.parse(jsonCallDispObject);
    		}
			if(jsonCallDispParse != null && jsonCallDispParse != "" && typeof jsonCallDispParse !== "undefined") {
				if(jsonCallDispParse["isDispose"] != "" && jsonCallDispParse["isDispose"] != null && typeof jsonCallDispParse["isDispose"] !== "undefined") {
					isDispose = jsonCallDispParse["isDispose"];
				}
			}
			agentRemarks = $("#agentRemarks").val();
			language = $("#language").val();
	    	disposition = $("#disposition").val();
	    	if(agentRemarks == null || agentRemarks == "" || typeof agentRemarks === "undefined") {
	    		$("#agentRemarks").addClass("errorborder");
	    		cbflag = false;
	    	} else {
	    		$("#agentRemarks").removeClass("errorborder");
	    	}
	    	
	    	if(disposition == null || disposition == "" || typeof disposition === "undefined") {
	    		$("#disposition").addClass("errorborder");
	    		cbflag = false;
	    	} else {
	    		$("#disposition").removeClass("errorborder");
	    	}
	    	
	    	if(!($("#subDisposition").is(':disabled'))) {
	    		$("#subDisposition option").each(function() {
		    		subdispoptioncount++;
		    	});
	    		subDisposition = $("#subDisposition").val();
		    	if(subdispoptioncount > 1) {
		    		if(subDisposition == null || subDisposition == "" || typeof subDisposition === "undefined") {
			    		$("#subDisposition").addClass("errorborder");
			    		cbflag = false;
			    	} else {
			    		$("#subDisposition").removeClass("errorborder");
			    	}
		    	} 
	    	} 
	    	
	    	if(disposition != null && disposition != "" && typeof disposition !== "undefined") {
	    		dispositionID = $("#disposition option:selected").attr("id");
				dispositionCode = $("#disposition option:selected").attr("data");
				
				// Added on 25-03-2017
				if(isActive == true) {
					if(dispositionXml != null) {
						var dispXmlDoc = $.parseXML(dispositionXml);
						$(dispXmlDoc).find("ROW").each(function() {
							//if($(this).find("DISPOSITIONCODE").text() == dispositionCode && $(this).find("DISPOSITIONID").text() == dispositionID && $(this).find("DISPOSITIONSTATE").text().toLowerCase() == "Not Contact".toLowerCase()) {
							if($(this).find("DISPOSITIONCODE").text() == dispositionCode && $(this).find("DISPOSITIONSTATE").text().toLowerCase() == "Not Contact".toLowerCase()) {
								contactFlag = true;
							}
						});
						 
					}
				}

				// Added on 25-03-2017
				if(isActive == false) {
					if(dispositionXml != null) {
						var dispXmlDoc = $.parseXML(dispositionXml);
						$(dispXmlDoc).find("ROW").each(function() {
							//if($(this).find("DISPOSITIONCODE").text() == dispositionCode && $(this).find("DISPOSITIONID").text() == dispositionID && $(this).find("DISPOSITIONSTATE").text().toLowerCase() != "Not Contact".toLowerCase()) {
							if($(this).find("DISPOSITIONCODE").text() == dispositionCode && $(this).find("DISPOSITIONSTATE").text().toLowerCase() != "Not Contact".toLowerCase()) {
								notContactFlag = true;
							}
						});
						// Commented on 26-06-2017
						/* if(notContactFlag) {
							alert("Please select Not Contact disposition");
							cbflag = false;
						} */
					}
				}
	    	}
	    	if(subDisposition != null && subDisposition != "" && typeof subDisposition !== "undefined") {
				subDispositionID = $("#subDisposition option:selected").attr("id");
				subDispositionCode = $("#subDisposition option:selected").attr("data");
	    	}
	    	
	    	// Commented on 15-05-2017
	    	/* for (var i = 0; i < dispJsonArray.length; i++) {
				if(jsonDisp[dispJsonArray[i]]["description"] == disposition) {
					callbackFlag = jsonDisp[dispJsonArray[i]]["callbackf"];
					salesFlag = jsonDisp[dispJsonArray[i]]["salesf"];
			    	exclusionFlag = jsonDisp[dispJsonArray[i]]["exclusionf"];
				}
			} */
	    	
	    	if(dispositionXml != null) {
				var dispXmlDoc = $.parseXML(dispositionXml);
				$(dispXmlDoc).find("ROW").each(function() {
 					if($(this).find("DISPOSITIONCODE").text() == dispositionCode) {
 						// Added on 15-05-2017
 						callbackFlag = $(this).find("CALLBACKFLAG").text();
 						category = $(this).find("DISPOSITIONSTATE").text();
 					}
 				});
			}
	    	
	    	if(callbackFlag == 1) {
	    		callBackNumber = $("#callBackNumber").val();
				callBackDateTime = $("#callbackdatetimepicker").val();
	    		
	    		if(callBackNumber == null || callBackNumber == "" || typeof callBackNumber === "undefined" || callBackNumber.length < 10) {
		    		$("#callBackNumber").addClass("errorborder");
		    		cbflag = false;
		    	} else {
		    		$("#callBackNumber").removeClass("errorborder");
		    	}
	    		
	    		if(!($("#callBackType").is(':disabled'))) {
	    			$("#callBackType option").each(function() {
						callbackTypeCount++;
			    	});
	    			callBackType = $("#callBackType").val();
					if(callbackTypeCount > 1) {
						if(callBackType == null || callBackType == "" || typeof callBackType === "undefined") {
				    		$("#callBackType").addClass("errorborder");
				    		cbflag = false;
				    	} else {
				    		$("#callBackType").removeClass("errorborder");
				    	}
					} 
	    		} else {
	    			callBackType = "Personal";
	    		}
	    		if(callBackType == "Personal") {
	    			callBackType = 1;
	    		}
	    		if(callBackType == "Campaign") {
	    			callBackType = 0;
	    		}
	    		var regex = /^\d{4}-(0[1-9]|1[0-2])-([0-2]\d|3[01]) (20|21|22|23|[0-1]?\d{1}):[0-5]\d$/;
	    		if(callBackDateTime == null || callBackDateTime == "" || typeof callBackDateTime === "undefined" || !regex.test(callBackDateTime)) {
		    		$("#callbackdatetimepicker").addClass("errorborder");
		    		cbflag = false;
		    	} else {
		    		$("#callbackdatetimepicker").removeClass("errorborder");
		    	}
	    	}
			
	    	if(cbflag && isDispose) {
				var callDetailsXmlData = "";
				var td1 = "";
				var td2 = "";
				var td3 = "";
				var td4 = "";
				var labelName1 = "";
				var labelValue1 = "";
				var labelName2 = "";
				var labelValue2 = "";
				
				agentName = $("#agentName").val();
				agentID = agentName;
				
				var tempCustomerID = 0;
				var batchID = 0;
				if(CustomerDetails != null && CustomerDetails != "" && typeof CustomerDetails !== "undefined") {
					tempCustomerID = CustomerDetails["CUSTOMERID"];
					batchID = CustomerDetails["BATCHID"];
				}
				
				var processxmlData = "<ROOT><PROCESS><FLDCUSTOMERID>" + tempCustomerID +"</FLDCUSTOMERID>";
				processxmlData += "</PROCESS>";
				processxmlData += "</ROOT>";
				
				if(jsonCallDispParse != null && jsonCallDispParse != "" && typeof jsonCallDispParse !== "undefined") {
					if(jsonCallDispParse[""] != "" && jsonCallDispParse["dialNumber"] != null && typeof jsonCallDispParse["dialNumber"] !== "undefined") {
						dialNumber = jsonCallDispParse["dialNumber"];
					}
					if(jsonCallDispParse["idleTime"] != "" && jsonCallDispParse["idleTime"] != null && typeof jsonCallDispParse["idleTime"] !== "undefined") {
						idleTime = jsonCallDispParse["idleTime"];
					}
					if(jsonCallDispParse["talkTime"] != "" && jsonCallDispParse["talkTime"] != null && typeof jsonCallDispParse["talkTime"] !== "undefined") {
						talkTime = jsonCallDispParse["talkTime"];
					}
					if(jsonCallDispParse["wrapTime"] != "" && jsonCallDispParse["wrapTime"] != null && typeof jsonCallDispParse["wrapTime"] !== "undefined") {
						wrapTime = jsonCallDispParse["wrapTime"];
					}
					if(jsonCallDispParse["holdTime"] != "" && jsonCallDispParse["holdTime"] != null && typeof jsonCallDispParse["holdTime"] !== "undefined") {
						holdTime = jsonCallDispParse["holdTime"];
					}
					if(jsonCallDispParse["previewTime"] != "" && jsonCallDispParse["previewTime"] != null && typeof jsonCallDispParse["previewTime"] !== "undefined") {
						previewTime = jsonCallDispParse["previewTime"];
					}
					if(jsonCallDispParse["callStartTime"] != "" && jsonCallDispParse["callStartTime"] != null && typeof jsonCallDispParse["callStartTime"] !== "undefined") {
						callStartTime = jsonCallDispParse["callStartTime"];
					}
					if(jsonCallDispParse["callEndTime"] != "" && jsonCallDispParse["callEndTime"] != null && typeof jsonCallDispParse["callEndTime"] !== "undefined") {
						callEndTime = jsonCallDispParse["callEndTime"];
					}
					if(jsonCallDispParse["sequenceNumber"] != "" && jsonCallDispParse["sequenceNumber"] != null && typeof jsonCallDispParse["sequenceNumber"] !== "undefined") {
						recordingSeq = jsonCallDispParse["sequenceNumber"];
					} else {
						recordingSeq = sequenceNumber;
					}
				}
				
				//recordingSeq = sequenceNumber;
				
				callDetailsXmlData += "<ROOT><CALLDETAILS>" +
				"<FLDCUSTOMERID>" + tempCustomerID + "</FLDCUSTOMERID>" +
				"<FLDBATCHID>" + batchID + "</FLDBATCHID>" +
				"<FLDAGENTNAME>" + agentName + "</FLDAGENTNAME>" +
				"<FLDAGENTID>" + agentID + "</FLDAGENTID>" +
				"<FLDCALLID>" + callID + "</FLDCALLID>" +
				"<FLDDIALLEDNUMBER>" + dialNumber + "</FLDDIALLEDNUMBER>" +
				"<FLDIDLETIME>" + idleTime + "</FLDIDLETIME>" +
				"<FLDTALKTIME>" + talkTime + "</FLDTALKTIME>" +
				"<FLDWRAPTIME>" + wrapTime + "</FLDWRAPTIME>" +
				"<FLDHOLDTIME>" + holdTime + "</FLDHOLDTIME>" +
				"<FLDPREVIEWTIME>" + previewTime + "</FLDPREVIEWTIME>" +
				"<FLDCALLSTARTTIME>" + callStartTime + "</FLDCALLSTARTTIME>" +
				"<FLDCALLENDTIME>" + callEndTime + "</FLDCALLENDTIME>" +
				"<FLDPROCESSID>" + processID + "</FLDPROCESSID>" +
				"<FLDSUBPROCESSID>" + subProcessID + "</FLDSUBPROCESSID>" +
				"<FLDAGENTREMARKS><![CDATA[" + replaceChars(agentRemarks) +"]]></FLDAGENTREMARKS>" +
				"<FLDDISPOSITIONID>" + dispositionID + "</FLDDISPOSITIONID>" +
				"<FLDDISPOSITIONCODE>" + dispositionCode + "</FLDDISPOSITIONCODE>" +
				"<FLDDISPOSITION>" + disposition + "</FLDDISPOSITION>" +
				"<FLDSUBDISPOSITION>" + subDisposition + "</FLDSUBDISPOSITION>" +
				"<FLDSUBDISPOSITIONCODE>" + subDispositionCode + "</FLDSUBDISPOSITIONCODE>" +
				"<DISPCALLBACKFLAG>" + callbackFlag + "</DISPCALLBACKFLAG>" +
				"<FLDCALLBACKNUMBER>" + callBackNumber + "</FLDCALLBACKNUMBER>" +
				"<FLDCALLBACKTYPE>" + callBackType + "</FLDCALLBACKTYPE>" +
				"<FLDCALLBACKDATE>" + callBackDateTime + "</FLDCALLBACKDATE>" +
				"<FLDLANGUAGE>" + language + "</FLDLANGUAGE>" +
				"<FLDDATE>" + date + "</FLDDATE>" +
				"<FLDSERVICEID>" + serviceID + "</FLDSERVICEID>" +
				"<FLDSERVICENAME>" + serviceName + "</FLDSERVICENAME>" +
				"<FLDCALLTABLE>" + tableName + "</FLDCALLTABLE>" +
				"<FLDAGENTINDEX>" + agentIndex + "</FLDAGENTINDEX>" +
				"<FLDAUTORECORDING>" + autoRecording + "</FLDAUTORECORDING>" +
				"<FLDFILENAME>" + fileName + "</FLDFILENAME>" +
				"<FLDMEDIATYPE>" + mediaType + "</FLDMEDIATYPE>" +
				"<FLDRECINDEX>" + recordingIndex + "</FLDRECINDEX>" +
				"<FLDRECRATE>" + recordingRate + "</FLDRECRATE>" +
				"<FLDRECSEQ>" + recordingSeq + "</FLDRECSEQ>" +
				"<FLDRECSTATE>" + recordingState + "</FLDRECSTATE>" +
				"<FLDRECSTOREID>" + recordingStoreID + "</FLDRECSTOREID>" +
				"</CALLDETAILS></ROOT>";
				
				
				var leadInsertFlag=true;
				
				//if($("#subProcess").attr("data") =='500'){ //YONO DROP OFF
					var d1=Date.parse(callBackDateTime);
					var d2=Date.parse(leadInsertedDate);
						var difftime=Math.abs(d1-d2);
					var daydiff=Math.ceil(difftime/(1000*60*60*24));
					alert("Day Difference: "+daydiff);
				if(daydiff>30){
				leadInsertFlag=false;
				}			
				//}
				
				if(leadInsertFlag){
				var data = "opcode=customerupdate&processXml=" + processxmlData + "&callDetailsXml=" + callDetailsXmlData;
				dispositons = {"disposeStatus" : cbflag, "seqNum" : recordingSeq, "dispID" : dispositionID, "dispCode" : dispositionCode, "dispDesc" : disposition, "salesf" : salesFlag, "callbackf" : callbackFlag, "exclusionf" : exclusionFlag, "callBackNumber" : callBackNumber, "callBackType" : callBackType, "callBackDateTime" : callBackDateTime, "snoozeValue" : 0};
				stringdisp = JSON.stringify(dispositons);
			    $.ajax({
			        type: "POST",
			        url: "portal",
			        data: data,
			        dataType: 'json',
			        //async: false,
			        success: function(response) {
			        	stopDisposeTimer();
			        	responseJSON = JSON.parse(JSON.stringify(response));
		        		statsDetails = responseJSON["AgentStatsDetails"];
		        		isActive = false;
			        	if(statsDetails["updateStatus"] == "Success" && statsDetails != null) {
				        	$("#leads").val(statsDetails["LEADS"] != "" ? statsDetails["LEADS"] : 0);
				        	$("#notcontact").val(statsDetails["NOTCONTACT"] != "" ? statsDetails["NOTCONTACT"] : 0);
							$("#rpc").val(statsDetails["RIGHTPARTYCONTACT"] != "" ? statsDetails["RIGHTPARTYCONTACT"] : 0);
							$("#cd").val(statsDetails["CALLDISCONNECT"] != "" ? statsDetails["CALLDISCONNECT"] : 0);
							$("#cb").val(statsDetails["CALLBACK"] != "" ? statsDetails["CALLBACK"] : 0);
							$("#tpc").val(statsDetails["THIRDPARTYCONTACT"] != "" ? statsDetails["THIRDPARTYCONTACT"] : 0);
							$("#successful").val(statsDetails["SUCCESSFULL"] != "" ? statsDetails["SUCCESSFULL"] : 0);
							$("#leadCallBack").val(statsDetails["LEADCALLBACK"] != "" ? statsDetails["LEADCALLBACK"] : 0);
							$("#autoWrap").val(statsDetails["AUTOWRAP"] != "" ? statsDetails["AUTOWRAP"] : 0);
							$("#totalcalls").val(statsDetails["TOTALCALLS"] != "" ? statsDetails["TOTALCALLS"] : 0);
							$("#loginHours").val(statsDetails["LOGINHOURS"] != "" ? statsDetails["LOGINHOURS"] : "00:00:00");
							$("#auxtime").val(statsDetails["AUXTIME"] != "" ? statsDetails["AUXTIME"] : "00:00:00");
							$("#lunch").val(statsDetails["LUNCH"] != "" ? statsDetails["LUNCH"] : "00:00:00");
							$("#teabreak").val(statsDetails["TEABREAK"] != "" ? statsDetails["TEABREAK"] : "00:00:00");
							$("#personalBreak").val(statsDetails["PERSONAL"] != "" ? statsDetails["PERSONAL"] : "00:00:00");
							$("#productiveTime").val(statsDetails["PRODUCTIVETIME"] != "" ? statsDetails["PRODUCTIVETIME"] : "00:00:00");
							$("#others").val(statsDetails["OTHERS"] != "" ? statsDetails["OTHERS"] : "00:00:00"); 
						 
			        		$("#navigationtabs").html("");
			        		$("#navigationtabs").hide();
			        		$("#processTable").hide();
			        		$("#historyshowdata").html("");
			        		$("#historydata").hide();
			        		// Added on 16-11-2017
			        		$("#bottomdiv").show();
			        		$("#agentscriptslinks").hide();
			        		
			        		// Added on 24-03-2017 LCS
			        		$("#lcstabdata").html();
			        		$("#lcstabdata").hide();
			        		// Ended
			        		
			        		$("#agentRemarks").val("");
			        		$("#callBackNumber").val("");
			        		$("#disposition").html("");
			        		// Added on 16-11-2017
			        		$("#disposition").append('<option id="159" data="THPY" value="Third Party">Third Party</option>');
							$("#subDisposition").html("");
							$("#callBackType").html("");
							$("#callbackdatetimepicker").val("");
							$('#bottomdiv input[type="radio"]').each(function () { 
								 $(this).prop('checked', false); 
							});
							//$("#language").html("");
			        		
			        		CustomerDetails = "";
							LOBDetails = "";
							AgentScriptDetails = "";
							labelMapDetails = "";
							orderMapDetails = "";
							subProcessDetails = "";
							processDetails = "";
							// Added on 24-03-2017 LCS
							lcsDetails = "";
			        	} else {
			        		stopDisposeTimer();
			        		$("#customerTable").html("");
			        		$("#customerTable").show();
			        	 
			        		$("#navigationtabs").html("");
			        		$("#navigationtabs").hide();
			        		$("#processTable").hide();
			        		$("#historyshowdata").html("");
			        		$("#historydata").hide();
			        		$("#agentscriptslinks").hide();
			        		$("#bottomdiv").hide();
			        		// Added on 24-03-2017 LCS
			        		$("#lcstabdata").html();
			        		$("#lcstabdata").hide();
			        		// Ended
			        		
			        		$("#agentRemarks").val("");
			        		$("#callBackNumber").val("");
			        		$("#disposition").html("");
							$("#subDisposition").html("");
							$("#callBackType").html("");
							$("#callbackdatetimepicker").val("");
							$('#bottomdiv input[type="radio"]').each(function () { 
								 $(this).prop('checked', false); 
							});
							//$("#language").html("");
			        		
			        		CustomerDetails = "";
							LOBDetails = "";
							AgentScriptDetails = "";
							labelMapDetails = "";
							orderMapDetails = "";
							subProcessDetails = "";
							processDetails = "";
							// Added on 24-03-2017 LCS
							lcsDetails = "";
			        	} 
			        },
			        error: function(e) {
			        }
			        
				});
			    
	    	}else{
				alert("Sorry!, Unable to process since callback duration expired");
				}
		     
	    	
	    	} else {
		    	  dispositons = {"disposeStatus" : cbflag};
		    	  stringdisp = JSON.stringify(dispositons);
		      }
	    	return stringdisp;
		}
		
				
		//mkvs
		function appletdispose(jsonCallDispObject) {
			
			
			
			// Added on 11-07-0217
			var jsDate = new Date();
	    	var jsLogDateTime = (jsDate.getDate() < 10 ? "0" + jsDate.getDate() : jsDate.getDate())  + "-" + ((jsDate.getMonth()) < 10 ? "0" + (jsDate.getMonth() + 1) : jsDate.getMonth() + 1) + "-" + jsDate.getFullYear() + " " + jsDate.getHours() + ":" + jsDate.getMinutes() + ":" + (jsDate.getSeconds() < 10 ? "0" + jsDate.getSeconds() : jsDate.getSeconds());
	    	writeFile.WriteLine(jsLogDateTime + " : Call Details : " +jsonCallDispObject);
			// Ended
			
			var flag = true; 
			var jsonCallDispParse = "";
			
			var agentName = "";
			var agentID = "";
			
			var processID = 0;
			var subProcessID = 0;
			var isDispose = false;
			
	    	var agentRemarks = "";
	    	var dispositionID = 0;
	    	var dispositionCode = "";
	    	var disposition = "";
			var subDispositionID = 0;
			var subDispositionCode = "";
			var subDisposition = "";
	    	var callbackFlag = 0;
	    	var salesFlag = 0;
	    	var exclusionFlag = 0;
	    	var category = "";
	    	var mandatoryFlag = 0;
	    	
	    	var callBackNumber = "";
			var callBackType = "";
			var callBackDateTime = "";
			var language = "";
			var date = "";
			
			var subdispoptioncount = 0;
			var callbackTypeCount = 0;
			var dispositons = "";
			var stringdisp= "";
			
			var idleTime = 0;
			var talkTime = 0;
			var wrapTime = 0;
			var holdTime = 0;
			var previewTime = 0;
			var callStartTime = "";
			var callEndTime = "";
			
			var currDate = new Date();
			var dt = currDate.getDate();
		    var month = currDate.getMonth() + 1; 
		    var year = currDate.getFullYear();
		    if(dt < 10) {
		    	dt = '0' + dt;
			} 
			if(month < 10) {
			    month = '0' + month;
			}
			date = year + "-" + month + "-" + dt;
			
			// Added on 24-03-2017 LCS
			var lcsTokenNo = "";
			
			// Added on 25-03-2017
			var contactFlag = false;
			var notContactFlag = false;
			
			if(CustomerDetails == "" && LOBDetails == "" && AgentScriptDetails == "" && labelMapDetails == "" && orderMapDetails == "" && subProcessDetails == "" && processDetails == "") {
				var stringdisp = callbackValidation(jsonCallDispObject);
				return stringdisp;
	    	} else {
	    		
	    		if(jsonCallDispObject != null && jsonCallDispObject != "" && typeof jsonCallDispObject !== "undefined") {
	    			jsonCallDispParse = JSON.parse(jsonCallDispObject);
	    		}
	    		
	    		if(jsonCallDispParse["isDispose"] != "" && jsonCallDispParse["isDispose"] != null && typeof jsonCallDispParse["isDispose"] !== "undefined") {
	    			isDispose = jsonCallDispParse["isDispose"];
				}
	    		
				if(processDetails != null && processDetails != "" &&  typeof processDetails !== "undefined") {
					processID = $("#lobInfo").attr("data");
				}
				if(subProcessDetails != null && subProcessDetails != "" &&  typeof subProcessDetails !== "undefined") {
					subProcessID = $("#subProcess").attr("data");
				}
	    		
				agentRemarks = $("#agentRemarks").val();
				language = $("#language").val();
		    	disposition = $("#disposition").val();
		    	if(agentRemarks == null || agentRemarks == "" || typeof agentRemarks === "undefined") {
		    		$("#agentRemarks").addClass("errorborder");
		    		flag = false;
		    	} else {
		    		$("#agentRemarks").removeClass("errorborder");
		    	}
		    	
		    	if(disposition == null || disposition == "" || typeof disposition === "undefined") {
		    		$("#disposition").addClass("errorborder");
		    		flag = false;
		    	} else {
		    		$("#disposition").removeClass("errorborder");
		    	}
		    	
		    	if(!($("#subDisposition").is(':disabled'))) {
		    		$("#subDisposition option").each(function() {
			    		subdispoptioncount++;
			    	});
		    		subDisposition = $("#subDisposition").val();
			    	if(subdispoptioncount > 1) {
			    		if(subDisposition == null || subDisposition == "" || typeof subDisposition === "undefined") {
				    		$("#subDisposition").addClass("errorborder");
				    		flag = false;
				    	} else {
				    		$("#subDisposition").removeClass("errorborder");
				    	}
			    	} 
		    	}
		    	
		    	if(disposition != null && disposition != "" && typeof disposition !== "undefined") {
		    		dispositionID = $("#disposition option:selected").attr("id");
					dispositionCode = $("#disposition option:selected").attr("data");
					
					// Added on 25-03-2017
					if(isActive == true) {
						if(dispositionXml != null) {
							var dispXmlDoc = $.parseXML(dispositionXml);
							$(dispXmlDoc).find("ROW").each(function() {
								//if($(this).find("DISPOSITIONCODE").text() == dispositionCode && $(this).find("DISPOSITIONID").text() == dispositionID && $(this).find("DISPOSITIONSTATE").text().toLowerCase() == "Not Contact".toLowerCase()) {
								if($(this).find("DISPOSITIONCODE").text() == dispositionCode && $(this).find("DISPOSITIONSTATE").text().toLowerCase() == "Not Contact".toLowerCase()) {
									contactFlag = true;
								}
							});
							// Commented on 26-06-2017
							/* if(contactFlag) {
								alert("Please select Contact disposition");
								flag = false;
							} */
						}
					}

					// Added on 25-03-2017
					if(isActive == false) {
						if(dispositionXml != null) {
							var dispXmlDoc = $.parseXML(dispositionXml);
							$(dispXmlDoc).find("ROW").each(function() {
								//if($(this).find("DISPOSITIONCODE").text() == dispositionCode && $(this).find("DISPOSITIONID").text() == dispositionID && $(this).find("DISPOSITIONSTATE").text().toLowerCase() != "Not Contact".toLowerCase()) {
								if($(this).find("DISPOSITIONCODE").text() == dispositionCode && $(this).find("DISPOSITIONSTATE").text().toLowerCase() != "Not Contact".toLowerCase()) {
									notContactFlag = true;
								}
							});
							 
						}
					}
					
		    	}
		    	if(subDisposition != null && subDisposition != "" && typeof subDisposition !== "undefined") {
					subDispositionID = $("#subDisposition option:selected").attr("id");
					subDispositionCode = $("#subDisposition option:selected").attr("data");
		    	}
		    	
		    	// Commented on 15-05-2017
		    	/* if(dispJsonArray != null && dispJsonArray != "" && typeof dispJsonArray !== "undefined") {
			    	for (var i = 0; i < dispJsonArray.length; i++) {
						if(jsonDisp[dispJsonArray[i]]["description"] == disposition) {
							callbackFlag = jsonDisp[dispJsonArray[i]]["callbackf"];
							salesFlag = jsonDisp[dispJsonArray[i]]["salesf"];
					    	exclusionFlag = jsonDisp[dispJsonArray[i]]["exclusionf"];
						}
					}
		    	} */
		    	
		    	if(dispositionXml != null) {
					var dispXmlDoc = $.parseXML(dispositionXml);
					$(dispXmlDoc).find("ROW").each(function() {
						if(dispositionCode != "" && dispositionCode != null) {
							//if($(this).find("DISPOSITIONCODE").text().toUpperCase() == dispositionCode.toUpperCase() && $(this).find("MANDATORYFLAG").text() == 1) {
							if($(this).find("DISPOSITIONCODE").text().toUpperCase() == dispositionCode.toUpperCase()) {
								// Added on 15-05-2017
								callbackFlag = $(this).find("CALLBACKFLAG").text();
								if($(this).find("MANDATORYFLAG").text() == 1) {
									mandatoryFlag = $(this).find("MANDATORYFLAG").text();
								}
							}
						}
					});
		    	}
		    	
		    	if(mandatoryFlag == 1) {
		    		var tableRow = $("#processTable").find("tr");
					var processLength = tableRow.length;
					for(var i = 0; i < processLength; i++) {
						td1 = tableRow.eq(i).find('td:eq(0)');
						td2 = tableRow.eq(i).find('td:eq(1)');
						td3 = tableRow.eq(i).find('td:eq(2)');
						td4 = tableRow.eq(i).find('td:eq(3)');
						
						if(td1.find("span").text() == "*") {
							// textfield validation
							if(typeof td2.find("input").val() !== "undefined") {
								if(td2.find("input").val() == null || td2.find("input").val() == "") {
									td2.find("input").addClass("errorborder");
									flag = false;
								} else {
									td2.find("input").removeClass("errorborder");
								}
							} else if(typeof td2.find("select").val() !== "undefined") {
								// dropdown validation
								if(td2.find("select").val() == null || td2.find("select").val() == "") {
									td2.find("select").addClass("errorborder");
									flag = false;
								} else {
									td2.find("select").removeClass("errorborder");
								}
							} else if(typeof td2.find("textarea").val() !== "undefined") {
								// textarea validation
								if(td2.find("textarea").val() == null || td2.find("textarea").val() == "") {
									td2.find("textarea").addClass("errorborder");
									flag = false;
								} else {
									td2.find("textarea").removeClass("errorborder");
								}
							}
						}
						if(td3.find("span").text() == "*") {
							if(typeof td4.find("input").val() !== "undefined") {
								// textfield validation
								if(td4.find("input").val() == null || td4.find("input").val() == "") {
									td4.find("input").addClass("errorborder");
									flag = false;
								} else {
									td4.find("input").removeClass("errorborder");
								}
							}
							if(typeof td4.find("select").val() !== "undefined") {
								// dropdown validation
								if(td4.find("select").val() == null || td4.find("select").val() == "") {
									td4.find("select").addClass("errorborder");
									flag = false;
								} else {
									td4.find("select").removeClass("errorborder");
								}
							}
							if(typeof td4.find("textarea").val() !== "undefined") {
								// textarea validation
								if(td4.find("textarea").val() == null || td4.find("textarea").val() == "") {
									td4.find("textarea").addClass("errorborder");
									flag = false;
								} else {
									td4.find("textarea").removeClass("errorborder");
								}
							}
						}
					}
		    	}
		    	
		    	if(callbackFlag == 1) {
		    		callBackNumber = $("#callBackNumber").val();
		    		// Added on 29-11-2017 for mask dial no's
					if(callBackNumber.indexOf("XXXX") == -1) {
						callBackNumber = $("#callBackNumber").val();
					} else {
						callBackNumber = dialNumber;
					}
					callBackDateTime = $("#callbackdatetimepicker").val();
					
		    		if(callBackNumber == null || callBackNumber == "" || typeof callBackNumber === "undefined" || callBackNumber.length < 10) {
			    		$("#callBackNumber").addClass("errorborder");
			    		flag = false;
			    	} else {
			    		$("#callBackNumber").removeClass("errorborder");
			    	}
		    		
		    		if(!($("#callBackType").is(':disabled'))) {
		    			$("#callBackType option").each(function() {
							callbackTypeCount++;
				    	});
		    			callBackType = $("#callBackType").val();
						if(callbackTypeCount > 1) {
							if(callBackType == null || callBackType == "" || typeof callBackType === "undefined") {
					    		$("#callBackType").addClass("errorborder");
					    		flag = false;
					    	} else {
					    		$("#callBackType").removeClass("errorborder");
					    	}
						} 
		    		} else {
		    			callBackType = "Personal";
		    		}
		    		if(callBackType == "Personal") {
	    				callBackType = 1;
		    		}
		    		if(callBackType == "Campaign") {
		    			callBackType = 0;
		    		}
		    		
		    		var regex = /^\d{4}-(0[1-9]|1[0-2])-([0-2]\d|3[01]) (20|21|22|23|[0-1]?\d{1}):[0-5]\d$/;
		    		if(callBackDateTime == null || callBackDateTime == "" || typeof callBackDateTime === "undefined" || !regex.test(callBackDateTime)) {
			    		$("#callbackdatetimepicker").addClass("errorborder");
			    		flag = false;
			    	} else {
			    		$("#callbackdatetimepicker").removeClass("errorborder");
			    	}
			    }
	    	}
			
			if(dispositionXml != null) {
				var dispXmlDoc = $.parseXML(dispositionXml);
				$(dispXmlDoc).find("ROW").each(function() {
					if(dispositionCode != "" && dispositionCode != null) {
						if($(this).find("DISPOSITIONCODE").text() == dispositionCode) {
	 						category = $(this).find("FINAL").text();
	 					}
					}
 				});
			}
			if(flag && isDispose == false) {
				if(category == "Successful") {
					if(confirm("Are you sure to dispose the call as " + disposition + " ?") == true) {
						flag = true;
					} else {
						flag = false;
					}
				}
			}
	    	if(flag && isDispose) {
			var callDetailsXmlData = "";
			var td1 = "";
			var td2 = "";
			var td3 = "";
			var td4 = "";
			var labelName1 = "";
			var labelValue1 = "";
			var labelName2 = "";
			var labelValue2 = "";
			
			agentName = $("#agentName").val();
			agentID = agentName;
			//closeWindow();
			var tempCustomerID = 0;
			var batchID = 0;
			if(CustomerDetails != null && CustomerDetails != "" && typeof CustomerDetails !== "undefined") {
				tempCustomerID = CustomerDetails["CUSTOMERID"];
				batchID = CustomerDetails["BATCHID"];
			}
			
			var processxmlData = "<ROOT><PROCESS><FLDCUSTOMERID>" + tempCustomerID +"</FLDCUSTOMERID>";
			var tableRow = $("#processTable").find("tr");
			var processLength = tableRow.length;
			for(var i = 0; i < processLength; i++) {
				td1 = tableRow.eq(i).find('td:eq(0)');
				td2 = tableRow.eq(i).find('td:eq(1)');
				td3 = tableRow.eq(i).find('td:eq(2)');
				td4 = tableRow.eq(i).find('td:eq(3)');
				
				if(td1 != null && td1 != "" && typeof td1 !== "undefined") {
					if(td1.find("label").attr("id") != null && typeof td1.find("label").attr("id") !== "undefined" && td1.find("label").attr("id") != "")
						labelName1 = td1.find("label").attr("id");
				}
				if(td2 != null && td2 != "" && typeof td2 !== "undefined") {
					if(td2.find("input").val() != null && typeof td2.find("input").val() !== "undefined" && td2.find("input").val() != "") {
						labelValue1 = td2.find("input").val();
					} else if(td2.find("textarea").val() != null && typeof td2.find("textarea").val() !== "undefined" && td2.find("textarea").val() != "") {
						labelValue1 = td2.find("textarea").val();
					} else if(td2.find("select").val() != null && typeof td2.find("select").val() !== "undefined" && td2.find("select").val() != "") {
						labelValue1 = td2.find("select").val();
					}
				}
				
				if(td3 != null && td3 != "" && typeof td3 !== "undefined") {
					if(td3.find("label").attr("id") != null && typeof td3.find("label").attr("id") !== "undefined" && td3.find("label").attr("id") != "")
						labelName2 = td3.find("label").attr("id");
				}
				if(td4 != null && td4 != "" && typeof td4 != "undefined") {
					if(td4.find("input").val() != null && typeof td4.find("input").val() !== "undefined" && td4.find("input").val() != "") {
						labelValue2 = td4.find("input").val();
					} else if(td4.find("textarea").val() != null && typeof td4.find("textarea").val() !== "undefined" && td4.find("textarea").val() != "") {
						labelValue2 = td4.find("textarea").val();
					} else if(td4.find("select").val() != null && typeof td4.find("select").val() !== "undefined" && td4.find("select").val() != "") {
						labelValue2 = td4.find("select").val();
					}
				}
				// MTK
				if((labelName1 != "" && labelValue1 != "") && (typeof labelName1 !== "undefined" && typeof labelValue1 !== "undefined") && (labelName1 != null && labelValue1 != null)) {
					processxmlData += "<" + labelName1 + "><![CDATA[" + replaceChars(labelValue1) + "]]></" + labelName1 + ">";
					//alert("labelName1m"+labelName1+"labelValue1m="+labelValue1);
					if(labelName1=="FLDFILLER3"){
						var PTPAmount=labelValue1;
					//	alert("Amount="+PTPAmount);
					}
					labelName1 = "";
					labelValue1 = "";
				}
				if((labelName2 != "" && labelValue2 != "") && (typeof labelName2 !== "undefined" && typeof labelValue2 !== "undefined") && (labelName2 != null && labelValue2 != null)) {
					processxmlData += "<" + labelName2 + "><![CDATA[" + replaceChars(labelValue2) + "]]></" + labelName2 + ">";
					//alert("labelName2m"+labelName2+"labelValue2m="+labelValue2);
					if(labelName2=="FLDFILLER2"){
						var PTPdate=labelValue2;
						//alert("Date="+PTPdate);
					}
					labelName2 = "";
					labelValue2 = "";
				}
			}
			processxmlData += "</PROCESS>";
			processxmlData += "</ROOT>";
			
			if(jsonCallDispParse != null && jsonCallDispParse != "" && typeof jsonCallDispParse !== "undefined") {
				if(jsonCallDispParse["dialNumber"] != "" && jsonCallDispParse["dialNumber"] != null && typeof jsonCallDispParse["dialNumber"] !== "undefined") {
					dialNumber = jsonCallDispParse["dialNumber"];
				}
				if(jsonCallDispParse["idleTime"] != "" && jsonCallDispParse["idleTime"] != null && typeof jsonCallDispParse["idleTime"] !== "undefined") {
					idleTime = jsonCallDispParse["idleTime"];
				}
				if(jsonCallDispParse["talkTime"] != "" && jsonCallDispParse["talkTime"] != null && typeof jsonCallDispParse["talkTime"] !== "undefined") {
					talkTime = jsonCallDispParse["talkTime"];
				}
				if(jsonCallDispParse["wrapTime"] != "" && jsonCallDispParse["wrapTime"] != null && typeof jsonCallDispParse["wrapTime"] !== "undefined") {
					wrapTime = jsonCallDispParse["wrapTime"];
				}
				if(jsonCallDispParse["holdTime"] != "" && jsonCallDispParse["holdTime"] != null && typeof jsonCallDispParse["holdTime"] !== "undefined") {
					holdTime = jsonCallDispParse["holdTime"];
				}
				if(jsonCallDispParse["previewTime"] != "" && jsonCallDispParse["previewTime"] != null && typeof jsonCallDispParse["previewTime"] !== "undefined") {
					previewTime = jsonCallDispParse["previewTime"];
				}
				if(jsonCallDispParse["callStartTime"] != "" && jsonCallDispParse["callStartTime"] != null && typeof jsonCallDispParse["callStartTime"] !== "undefined") {
					callStartTime = jsonCallDispParse["callStartTime"];
				}
				if(jsonCallDispParse["callEndTime"] != "" && jsonCallDispParse["callEndTime"] != null && typeof jsonCallDispParse["callEndTime"] !== "undefined") {
					callEndTime = jsonCallDispParse["callEndTime"];
				}
				// Added on 24-03-2017 LCS
				if(jsonCallDispParse["lcsTokenNo"] != "" && jsonCallDispParse["lcsTokenNo"] != null && typeof jsonCallDispParse["lcsTokenNo"] !== "undefined") {
					lcsTokenNo = jsonCallDispParse["lcsTokenNo"];
				}
				// Ended
				if(jsonCallDispParse["sequenceNumber"] != "" && jsonCallDispParse["sequenceNumber"] != null && typeof jsonCallDispParse["sequenceNumber"] !== "undefined") {
					recordingSeq = jsonCallDispParse["sequenceNumber"];
				} else {
					recordingSeq = sequenceNumber;
				}
			}
			
			//recordingSeq = sequenceNumber;
			
			callDetailsXmlData += "<ROOT><CALLDETAILS>" +
			"<FLDCUSTOMERID>" + tempCustomerID + "</FLDCUSTOMERID>" +
			"<FLDBATCHID>" + batchID + "</FLDBATCHID>" +
			"<FLDAGENTNAME>" + agentName + "</FLDAGENTNAME>" +
			"<FLDAGENTID>" + agentID + "</FLDAGENTID>" +
			"<FLDCALLID>" + callID + "</FLDCALLID>" +
			"<FLDDIALLEDNUMBER>" + dialNumber + "</FLDDIALLEDNUMBER>" +
			"<FLDIDLETIME>" + idleTime + "</FLDIDLETIME>" +
			"<FLDTALKTIME>" + talkTime + "</FLDTALKTIME>" +
			"<FLDWRAPTIME>" + wrapTime + "</FLDWRAPTIME>" +
			"<FLDHOLDTIME>" + holdTime + "</FLDHOLDTIME>" +
			"<FLDPREVIEWTIME>" + previewTime + "</FLDPREVIEWTIME>" +
			"<FLDCALLSTARTTIME>" + callStartTime + "</FLDCALLSTARTTIME>" +
			"<FLDCALLENDTIME>" + callEndTime + "</FLDCALLENDTIME>" +
			"<FLDPROCESSID>" + processID + "</FLDPROCESSID>" +
			"<FLDSUBPROCESSID>" + subProcessID + "</FLDSUBPROCESSID>" +
			"<FLDAGENTREMARKS><![CDATA[" + replaceChars(agentRemarks) +"]]></FLDAGENTREMARKS>" +
			"<FLDDISPOSITIONID>" + dispositionID + "</FLDDISPOSITIONID>" +
			"<FLDDISPOSITIONCODE>" + dispositionCode + "</FLDDISPOSITIONCODE>" +
			"<FLDDISPOSITION>" + disposition + "</FLDDISPOSITION>" +
			"<FLDSUBDISPOSITION>" + subDisposition + "</FLDSUBDISPOSITION>" +
			"<FLDSUBDISPOSITIONCODE>" + subDispositionCode + "</FLDSUBDISPOSITIONCODE>" +
			"<DISPCALLBACKFLAG>" + callbackFlag + "</DISPCALLBACKFLAG>" +
			"<FLDCALLBACKNUMBER>" + callBackNumber + "</FLDCALLBACKNUMBER>" +
			"<FLDCALLBACKTYPE>" + callBackType + "</FLDCALLBACKTYPE>" +
			"<FLDCALLBACKDATE>" + callBackDateTime + "</FLDCALLBACKDATE>" +
			"<FLDLANGUAGE>" + language + "</FLDLANGUAGE>" +
			"<FLDDATE>" + date + "</FLDDATE>" +
			"<FLDSERVICEID>" + serviceID + "</FLDSERVICEID>" +
			"<FLDSERVICENAME>" + serviceName + "</FLDSERVICENAME>" +
			"<FLDCALLTABLE>" + tableName + "</FLDCALLTABLE>" +
			"<FLDAGENTINDEX>" + agentIndex + "</FLDAGENTINDEX>" +
			"<FLDAUTORECORDING>" + autoRecording + "</FLDAUTORECORDING>" +
			"<FLDFILENAME>" + fileName + "</FLDFILENAME>" +
			"<FLDMEDIATYPE>" + mediaType + "</FLDMEDIATYPE>" +
			"<FLDRECINDEX>" + recordingIndex + "</FLDRECINDEX>" +
			"<FLDRECRATE>" + recordingRate + "</FLDRECRATE>" +
			"<FLDRECSEQ>" + recordingSeq + "</FLDRECSEQ>" +
			"<FLDRECSTATE>" + recordingState + "</FLDRECSTATE>" +
			"<FLDRECSTOREID>" + recordingStoreID + "</FLDRECSTOREID>" +
			"<FLDLCSTOKENNO>" + lcsTokenNo + "</FLDLCSTOKENNO>" + // Added on 24-03-2017 LCS
			"</CALLDETAILS></ROOT>";
			
			// Added on 11-07-0217
			var jsDate = new Date();
	    	var jsLogDateTime = (jsDate.getDate() < 10 ? "0" + jsDate.getDate() : jsDate.getDate())  + "-" + ((jsDate.getMonth()) < 10 ? "0" + (jsDate.getMonth() + 1) : jsDate.getMonth() + 1) + "-" + jsDate.getFullYear() + " " + jsDate.getHours() + ":" + jsDate.getMinutes() + ":" + (jsDate.getSeconds() < 10 ? "0" + jsDate.getSeconds() : jsDate.getSeconds());
	    	writeFile.WriteLine(jsLogDateTime + " : Process Xml Data : " + processxmlData);
	    	writeFile.WriteLine(jsLogDateTime + " : CallDetails Xml Data : " + callDetailsXmlData);
			// Ended
			
			var data = "opcode=customerupdate&processXml=" + processxmlData + "&callDetailsXml=" + callDetailsXmlData;
			dispositons = {"disposeStatus" : flag, "seqNum" : recordingSeq, "dispID" : dispositionID, "dispCode" : dispositionCode, "dispDesc" : disposition, "salesf" : salesFlag, "callbackf" : callbackFlag, "exclusionf" : exclusionFlag, "callBackNumber" : callBackNumber, "callBackType" : callBackType, "callBackDateTime" : callBackDateTime, "snoozeValue" : 0};
			stringdisp = JSON.stringify(dispositons);
		    $.ajax({
		        type: "POST",
		        url: "portal",
		        data: data,
		        dataType: 'json',
		        //async: false,
		        success: function(response) {
		        	// Added on 11-07-0217
		        	var jsDate = new Date();
	    			var jsLogDateTime = (jsDate.getDate() < 10 ? "0" + jsDate.getDate() : jsDate.getDate())  + "-" + ((jsDate.getMonth()) < 10 ? "0" + (jsDate.getMonth() + 1) : jsDate.getMonth() + 1) + "-" + jsDate.getFullYear() + " " + jsDate.getHours() + ":" + jsDate.getMinutes() + ":" + (jsDate.getSeconds() < 10 ? "0" + jsDate.getSeconds() : jsDate.getSeconds());
		        	writeFile.WriteLine(jsLogDateTime + " : appletdispose Success : " + JSON.stringify(response));
		        	// Ended		        	
		        	stopDisposeTimer();
		        	responseJSON = JSON.parse(JSON.stringify(response));
		        	statsDetails = responseJSON["AgentStatsDetails"];
		        	isActive = false;
		        	if(statsDetails["updateStatus"] == "Success" && statsDetails != null) {
			        	$("#leads").val(statsDetails["LEADS"] != "" ? statsDetails["LEADS"] : 0);
			        	$("#notcontact").val(statsDetails["NOTCONTACT"] != "" ? statsDetails["NOTCONTACT"] : 0);
						$("#rpc").val(statsDetails["RIGHTPARTYCONTACT"] != "" ? statsDetails["RIGHTPARTYCONTACT"] : 0);
						$("#cd").val(statsDetails["CALLDISCONNECT"] != "" ? statsDetails["CALLDISCONNECT"] : 0);
						$("#cb").val(statsDetails["CALLBACK"] != "" ? statsDetails["CALLBACK"] : 0);
						$("#tpc").val(statsDetails["THIRDPARTYCONTACT"] != "" ? statsDetails["THIRDPARTYCONTACT"] : 0);
						$("#successful").val(statsDetails["SUCCESSFULL"] != "" ? statsDetails["SUCCESSFULL"] : 0);
						$("#leadCallBack").val(statsDetails["LEADCALLBACK"] != "" ? statsDetails["LEADCALLBACK"] : 0);
						$("#autoWrap").val(statsDetails["AUTOWRAP"] != "" ? statsDetails["AUTOWRAP"] : 0);
						$("#totalcalls").val(statsDetails["TOTALCALLS"] != "" ? statsDetails["TOTALCALLS"] : 0);
						$("#loginHours").val(statsDetails["LOGINHOURS"] != "" ? statsDetails["LOGINHOURS"] : "00:00:00");
						$("#auxtime").val(statsDetails["AUXTIME"] != "" ? statsDetails["AUXTIME"] : "00:00:00");
						$("#lunch").val(statsDetails["LUNCH"] != "" ? statsDetails["LUNCH"] : "00:00:00");
						$("#teabreak").val(statsDetails["TEABREAK"] != "" ? statsDetails["TEABREAK"] : "00:00:00");
						$("#personalBreak").val(statsDetails["PERSONAL"] != "" ? statsDetails["PERSONAL"] : "00:00:00");
						$("#productiveTime").val(statsDetails["PRODUCTIVETIME"] != "" ? statsDetails["PRODUCTIVETIME"] : "00:00:00");
						$("#others").val(statsDetails["OTHERS"] != "" ? statsDetails["OTHERS"] : "00:00:00"); 
						
						$("#customerTable").html("");
		        		$("#customerTable").show();
		        	/* 	$("#customerTable").append('<div style="height: 387px; line-height: 350px;">' + 
			    		'<h1 id="customerBody" style="color: green; text-align: center; font-size: 50px;">Waiting For Call</h1>' +
			    		'</div>'); */
		        		$("#navigationtabs").html("");
		        		$("#navigationtabs").hide();
		        		$("#processTable").hide();
		        		$("#historyshowdata").html("");
		        		$("#historydata").hide();
		        		// Added on 16-11-2017
		        		$("#bottomdiv").show();
		        		$("#agentscriptslinks").hide();
		        		// Added on 24-03-2017 LCS
		        		$("#lcstabdata").html();
		        		$("#lcstabdata").hide();
		        		// Ended
		        		
		        		$("#agentRemarks").val("");
		        		$("#callBackNumber").val("");
		        		$("#disposition").html("");
		        		// Added on 16-11-2017
		        		$("#disposition").append('<option id="159" data="THPY" value="Third Party">Third Party</option>');
						$("#subDisposition").html("");
						$("#callBackType").html("");
						$("#callbackdatetimepicker").val("");
						$('#bottomdiv input[type="radio"]').each(function () { 
							 $(this).prop('checked', false); 
						});
					//	$("#language").html("");
		        		
		        		CustomerDetails = "";
						LOBDetails = "";
						AgentScriptDetails = "";
						labelMapDetails = "";
						orderMapDetails = "";
						subProcessDetails = "";
						processDetails = "";
						// Added on 24-03-2017 LCS
						lcsDetails = "";
						
		        	} else {
		        		stopDisposeTimer();
		        		$("#customerTable").html("");
		        		$("#customerTable").show();
		        		$("#customerTable").append('<div style="height: 387px; line-height: 350px;">' + 
			    		'<h1 id="customerBody" style="color: green; text-align: center; font-size: 50px;">Waiting For a Call</h1>' +
			    		'<h2 style="color :red; text-align: center; margin-top:-335px">Data Save Failed</h2>' +
			    		'</div>');
		        		$("#navigationtabs").html("");
		        		$("#navigationtabs").hide();
		        		$("#processTable").hide();
		        		$("#historyshowdata").html("");
		        		$("#historydata").hide();
		        		$("#agentscriptslinks").hide();
		        		// Added on 16-11-2017
		        		$("#bottomdiv").show();
		        		// Added on 24-03-2017 LCS
		        		$("#lcstabdata").html();
		        		$("#lcstabdata").hide();
		        		// Ended
		        		
		        		$("#agentRemarks").val("");
		        		$("#callBackNumber").val("");
		        		$("#disposition").html("");
		        		// Added on 16-11-2017
		        		$("#disposition").append('<option id="159" data="THPY" value="Third Party">Third Party</option>');
						$("#subDisposition").html("");
						$("#callBackType").html("");
						$("#callbackdatetimepicker").val("");
						$('#bottomdiv input[type="radio"]').each(function () { 
							 $(this).prop('checked', false); 
						});
						//$("#language").html("");
		        		
		        		CustomerDetails = "";
						LOBDetails = "";
						AgentScriptDetails = "";
						labelMapDetails = "";
						orderMapDetails = "";
						subProcessDetails = "";
						processDetails = "";
						// Added on 24-03-2017 LCS
						lcsDetails = "";
		        	} 
		        },
		        error: function(xhr, status, error) {
		        	// Added on 11-07-0217
		        	var jsDate = new Date();
	    			var jsLogDateTime = (jsDate.getDate() < 10 ? "0" + jsDate.getDate() : jsDate.getDate())  + "-" + ((jsDate.getMonth()) < 10 ? "0" + (jsDate.getMonth() + 1) : jsDate.getMonth() + 1) + "-" + jsDate.getFullYear() + " " + jsDate.getHours() + ":" + jsDate.getMinutes() + ":" + (jsDate.getSeconds() < 10 ? "0" + jsDate.getSeconds() : jsDate.getSeconds());
				    writeFile.WriteLine(jsLogDateTime + " : Status : " + status + " Error : " + error);
		        	// Ended
		        }
			});
	      } else {
	    	  dispositons = {"disposeStatus" : flag};
	    	  stringdisp = JSON.stringify(dispositons);
	      }
	      return stringdisp;
		}
		
		function appletfaileddispose(jsonCallDispObject) {
			var flag = true; 
			var jsonCallDispParse = "";
			
			var agentName = "";
			var agentID = "";
			
			var processID = 0;
			var subProcessID = 0;
			var isDispose = false;
			
	    	var agentRemarks = "";
	    	var dispositionID = 0;
	    	var dispositionCode = "";
	    	var disposition = "";
			var subDispositionID = 0;
			var subDispositionCode = "";
			var subDisposition = "";
	    	var callbackFlag = 0;
	    	var salesFlag = 0;
	    	var exclusionFlag = 0;
	    	var category = "";
	    	var mandatoryFlag = 0;
	    	
	    	var callBackNumber = "";
			var callBackType = "";
			var callBackDateTime = "";
			var language = "";
			var date = "";
			
			var subdispoptioncount = 0;
			var callbackTypeCount = 0;
			var dispositons = "";
			var stringdisp= "";
			
			var idleTime = 0;
			var talkTime = 0;
			var wrapTime = 0;
			var holdTime = 0;
			var previewTime = 0;
			var callStartTime = "";
			var callEndTime = "";
			
			var currDate = new Date();
			var dt = currDate.getDate();
		    var month = currDate.getMonth() + 1; 
		    var year = currDate.getFullYear();
		    if(dt < 10) {
		    	dt = '0' + dt;
			} 
			if(month < 10) {
			    month = '0' + month;
			}
			date = year + "-" + month + "-" + dt;
			
			// Added on 24-03-2017 LCS
			var lcsTokenNo = "";
			
    		if(jsonCallDispObject != null && jsonCallDispObject != "" && typeof jsonCallDispObject !== "undefined") {
    			jsonCallDispParse = JSON.parse(jsonCallDispObject);
    		}
    		
			if(processDetails != null && processDetails != "" &&  typeof processDetails !== "undefined") {
				processID = $("#lobInfo").attr("data");
			}
			if(subProcessDetails != null && subProcessDetails != "" &&  typeof subProcessDetails !== "undefined") {
				subProcessID = $("#subProcess").attr("data");
			}
			
			agentRemarks = $("#agentRemarks").val();
			language = $("#language").val();
	    	disposition = "No Contact_Call Back_1";
	    	dispositionID = 228;
			dispositionCode = "CBNC1";
	    	
    		var tableRow = $("#processTable").find("tr");
			var processLength = tableRow.length;
			for(var i = 0; i < processLength; i++) {
				td1 = tableRow.eq(i).find('td:eq(0)');
				td2 = tableRow.eq(i).find('td:eq(1)');
				td3 = tableRow.eq(i).find('td:eq(2)');
				td4 = tableRow.eq(i).find('td:eq(3)');
				
				if(td1.find("span").text() == "*") {
					// textfield validation
					if(typeof td2.find("input").val() !== "undefined") {
						if(td2.find("input").val() == null || td2.find("input").val() == "") {
							td2.find("input").addClass("errorborder");
							flag = false;
						} else {
							td2.find("input").removeClass("errorborder");
						}
					} else if(typeof td2.find("select").val() !== "undefined") {
						// dropdown validation
						if(td2.find("select").val() == null || td2.find("select").val() == "") {
							td2.find("select").addClass("errorborder");
							flag = false;
						} else {
							td2.find("select").removeClass("errorborder");
						}
					} else if(typeof td2.find("textarea").val() !== "undefined") {
						// textarea validation
						if(td2.find("textarea").val() == null || td2.find("textarea").val() == "") {
							td2.find("textarea").addClass("errorborder");
							flag = false;
						} else {
							td2.find("textarea").removeClass("errorborder");
						}
					}
				}
				if(td3.find("span").text() == "*") {
					if(typeof td4.find("input").val() !== "undefined") {
						// textfield validation
						if(td4.find("input").val() == null || td4.find("input").val() == "") {
							td4.find("input").addClass("errorborder");
							flag = false;
						} else {
							td4.find("input").removeClass("errorborder");
						}
					}
					if(typeof td4.find("select").val() !== "undefined") {
						// dropdown validation
						if(td4.find("select").val() == null || td4.find("select").val() == "") {
							td4.find("select").addClass("errorborder");
							flag = false;
						} else {
							td4.find("select").removeClass("errorborder");
						}
					}
					if(typeof td4.find("textarea").val() !== "undefined") {
						// textarea validation
						if(td4.find("textarea").val() == null || td4.find("textarea").val() == "") {
							td4.find("textarea").addClass("errorborder");
							flag = false;
						} else {
							td4.find("textarea").removeClass("errorborder");
						}
					}
				}
			}
	    	
			callbackFlag = 1;
    		callBackNumber = $("#callBackNumber").val();
			callBackType = 1;
			
			var callDetailsXmlData = "";
			var td1 = "";
			var td2 = "";
			var td3 = "";
			var td4 = "";
			var labelName1 = "";
			var labelValue1 = "";
			var labelName2 = "";
			var labelValue2 = "";
			
			agentName = $("#agentName").val();
			agentID = agentName;
			
			var tempCustomerID = 0;
			var batchID = 0;
			if(CustomerDetails != null && CustomerDetails != "" && typeof CustomerDetails !== "undefined") {
				tempCustomerID = CustomerDetails["CUSTOMERID"];
				batchID = CustomerDetails["BATCHID"];
			}
			
			var processxmlData = "<ROOT><PROCESS><FLDCUSTOMERID>" + tempCustomerID +"</FLDCUSTOMERID>";
			var tableRow = $("#processTable").find("tr");
			var processLength = tableRow.length;
			for(var i = 0; i < processLength; i++) {
				td1 = tableRow.eq(i).find('td:eq(0)');
				td2 = tableRow.eq(i).find('td:eq(1)');
				td3 = tableRow.eq(i).find('td:eq(2)');
				td4 = tableRow.eq(i).find('td:eq(3)');
				
				if(td1 != null && td1 != "" && typeof td1 !== "undefined") {
					if(td1.find("label").attr("id") != null && typeof td1.find("label").attr("id") !== "undefined" && td1.find("label").attr("id") != "")
						labelName1 = td1.find("label").attr("id");
				}
				if(td2 != null && td2 != "" && typeof td2 !== "undefined") {
					if(td2.find("input").val() != null && typeof td2.find("input").val() !== "undefined" && td2.find("input").val() != "") {
						labelValue1 = td2.find("input").val();
					} else if(td2.find("textarea").val() != null && typeof td2.find("textarea").val() !== "undefined" && td2.find("textarea").val() != "") {
						labelValue1 = td2.find("textarea").val();
					} else if(td2.find("select").val() != null && typeof td2.find("select").val() !== "undefined" && td2.find("select").val() != "") {
						labelValue1 = td2.find("select").val();
					}
				}
				
				if(td3 != null && td3 != "" && typeof td3 !== "undefined") {
					if(td3.find("label").attr("id") != null && typeof td3.find("label").attr("id") !== "undefined" && td3.find("label").attr("id") != "")
						labelName2 = td3.find("label").attr("id");
				}
				if(td4 != null && td4 != "" && typeof td4 != "undefined") {
					if(td4.find("input").val() != null && typeof td4.find("input").val() !== "undefined" && td4.find("input").val() != "") {
						labelValue2 = td4.find("input").val();
					} else if(td4.find("textarea").val() != null && typeof td4.find("textarea").val() !== "undefined" && td4.find("textarea").val() != "") {
						labelValue2 = td4.find("textarea").val();
					} else if(td4.find("select").val() != null && typeof td4.find("select").val() !== "undefined" && td4.find("select").val() != "") {
						labelValue2 = td4.find("select").val();
					}
				}
				if((labelName1 != "" && labelValue1 != "") && (typeof labelName1 !== "undefined" && typeof labelValue1 !== "undefined") && (labelName1 != null && labelValue1 != null)) {
					processxmlData += "<" + labelName1 + "><![CDATA[" + replaceChars(labelValue1) + "]]></" + labelName1 + ">";
					//alert("labelName1m"+labelName1+"labelValue1m="+labelValue1);
					if(labelName1=="FLDFILLER3"){
						var PTPAmount=labelValue1;
						//alert("Amount="+PTPAmount);
					}
						labelName1 = "";
						labelValue1 = "";
					 
				}
				if((labelName2 != "" && labelValue2 != "") && (typeof labelName2 !== "undefined" && typeof labelValue2 !== "undefined") && (labelName2 != null && labelValue2 != null)) {
					processxmlData += "<" + labelName2 + "><![CDATA[" + replaceChars(labelValue2) + "]]></" + labelName2 + ">";
					//alert("labelName2m"+labelName2+"labelValue2m="+labelValue2);
					if(labelName2=="FLDFILLER2"){
						var PTPdate=labelValue2;
						//alert("Date="+PTPdate);
					}
					
					labelName2 = "";
					labelValue2 = ""; 
				}
			}
			processxmlData += "</PROCESS>";
			processxmlData += "</ROOT>";
			
			if(jsonCallDispParse != null && jsonCallDispParse != "" && typeof jsonCallDispParse !== "undefined") {
				if(jsonCallDispParse["dialNumber"] != "" && jsonCallDispParse["dialNumber"] != null && typeof jsonCallDispParse["dialNumber"] !== "undefined") {
					dialNumber = jsonCallDispParse["dialNumber"];
				}
				if(jsonCallDispParse["idleTime"] != "" && jsonCallDispParse["idleTime"] != null && typeof jsonCallDispParse["idleTime"] !== "undefined") {
					idleTime = jsonCallDispParse["idleTime"];
				}
				if(jsonCallDispParse["talkTime"] != "" && jsonCallDispParse["talkTime"] != null && typeof jsonCallDispParse["talkTime"] !== "undefined") {
					talkTime = jsonCallDispParse["talkTime"];
				}
				if(jsonCallDispParse["wrapTime"] != "" && jsonCallDispParse["wrapTime"] != null && typeof jsonCallDispParse["wrapTime"] !== "undefined") {
					wrapTime = jsonCallDispParse["wrapTime"];
				}
				if(jsonCallDispParse["holdTime"] != "" && jsonCallDispParse["holdTime"] != null && typeof jsonCallDispParse["holdTime"] !== "undefined") {
					holdTime = jsonCallDispParse["holdTime"];
				}
				if(jsonCallDispParse["previewTime"] != "" && jsonCallDispParse["previewTime"] != null && typeof jsonCallDispParse["previewTime"] !== "undefined") {
					previewTime = jsonCallDispParse["previewTime"];
				}
				if(jsonCallDispParse["callStartTime"] != "" && jsonCallDispParse["callStartTime"] != null && typeof jsonCallDispParse["callStartTime"] !== "undefined") {
					callStartTime = jsonCallDispParse["callStartTime"];
				}
				if(jsonCallDispParse["callEndTime"] != "" && jsonCallDispParse["callEndTime"] != null && typeof jsonCallDispParse["callEndTime"] !== "undefined") {
					callEndTime = jsonCallDispParse["callEndTime"];
				}
				// Added on 24-03-2017 LCS
				if(jsonCallDispParse["lcsTokenNo"] != "" && jsonCallDispParse["lcsTokenNo"] != null && typeof jsonCallDispParse["lcsTokenNo"] !== "undefined") {
					lcsTokenNo = jsonCallDispParse["lcsTokenNo"];
				}
				// Ended
				if(jsonCallDispParse["sequenceNumber"] != "" && jsonCallDispParse["sequenceNumber"] != null && typeof jsonCallDispParse["sequenceNumber"] !== "undefined") {
					recordingSeq = jsonCallDispParse["sequenceNumber"];
				} else {
					recordingSeq = sequenceNumber;
				}
				if(jsonCallDispParse["callBackDateTime"] != "" && jsonCallDispParse["callBackDateTime"] != null && typeof jsonCallDispParse["callBackDateTime"] !== "undefined") {
					callBackDateTime = jsonCallDispParse["callBackDateTime"];
				}
			}
			
			//recordingSeq = sequenceNumber;
			
			callDetailsXmlData += "<ROOT><CALLDETAILS>" +
			"<FLDCUSTOMERID>" + tempCustomerID + "</FLDCUSTOMERID>" +
			"<FLDBATCHID>" + batchID + "</FLDBATCHID>" +
			"<FLDAGENTNAME>" + agentName + "</FLDAGENTNAME>" +
			"<FLDAGENTID>" + agentID + "</FLDAGENTID>" +
			"<FLDCALLID>" + callID + "</FLDCALLID>" +
			"<FLDDIALLEDNUMBER>" + dialNumber + "</FLDDIALLEDNUMBER>" +
			"<FLDIDLETIME>" + idleTime + "</FLDIDLETIME>" +
			"<FLDTALKTIME>" + talkTime + "</FLDTALKTIME>" +
			"<FLDWRAPTIME>" + wrapTime + "</FLDWRAPTIME>" +
			"<FLDHOLDTIME>" + holdTime + "</FLDHOLDTIME>" +
			"<FLDPREVIEWTIME>" + previewTime + "</FLDPREVIEWTIME>" +
			"<FLDCALLSTARTTIME>" + callStartTime + "</FLDCALLSTARTTIME>" +
			"<FLDCALLENDTIME>" + callEndTime + "</FLDCALLENDTIME>" +
			"<FLDPROCESSID>" + processID + "</FLDPROCESSID>" +
			"<FLDSUBPROCESSID>" + subProcessID + "</FLDSUBPROCESSID>" +
			"<FLDAGENTREMARKS><![CDATA[" + replaceChars(agentRemarks) +"]]></FLDAGENTREMARKS>" +
			"<FLDDISPOSITIONID>" + dispositionID + "</FLDDISPOSITIONID>" +
			"<FLDDISPOSITIONCODE>" + dispositionCode + "</FLDDISPOSITIONCODE>" +
			"<FLDDISPOSITION>" + disposition + "</FLDDISPOSITION>" +
			"<FLDSUBDISPOSITION>" + subDisposition + "</FLDSUBDISPOSITION>" +
			"<FLDSUBDISPOSITIONCODE>" + subDispositionCode + "</FLDSUBDISPOSITIONCODE>" +
			"<DISPCALLBACKFLAG>" + callbackFlag + "</DISPCALLBACKFLAG>" +
			"<FLDCALLBACKNUMBER>" + callBackNumber + "</FLDCALLBACKNUMBER>" +
			"<FLDCALLBACKTYPE>" + callBackType + "</FLDCALLBACKTYPE>" +
			"<FLDCALLBACKDATE>" + callBackDateTime + "</FLDCALLBACKDATE>" +
			"<FLDLANGUAGE>" + language + "</FLDLANGUAGE>" +
			"<FLDDATE>" + date + "</FLDDATE>" +
			"<FLDSERVICEID>" + serviceID + "</FLDSERVICEID>" +
			"<FLDSERVICENAME>" + serviceName + "</FLDSERVICENAME>" +
			"<FLDCALLTABLE>" + tableName + "</FLDCALLTABLE>" +
			"<FLDAGENTINDEX>" + agentIndex + "</FLDAGENTINDEX>" +
			"<FLDAUTORECORDING>" + autoRecording + "</FLDAUTORECORDING>" +
			"<FLDFILENAME>" + fileName + "</FLDFILENAME>" +
			"<FLDMEDIATYPE>" + mediaType + "</FLDMEDIATYPE>" +
			"<FLDRECINDEX>" + recordingIndex + "</FLDRECINDEX>" +
			"<FLDRECRATE>" + recordingRate + "</FLDRECRATE>" +
			"<FLDRECSEQ>" + recordingSeq + "</FLDRECSEQ>" +
			"<FLDRECSTATE>" + recordingState + "</FLDRECSTATE>" +
			"<FLDRECSTOREID>" + recordingStoreID + "</FLDRECSTOREID>" +
			"<FLDLCSTOKENNO>" + lcsTokenNo + "</FLDLCSTOKENNO>" + // Added on 24-03-2017 LCS
			"</CALLDETAILS></ROOT>";
			
			var data = "opcode=customerupdate&processXml=" + processxmlData + "&callDetailsXml=" + callDetailsXmlData;
			//dispositons = {"disposeStatus" : flag, "seqNum" : recordingSeq, "dispID" : dispositionID, "dispCode" : dispositionCode, "dispDesc" : disposition, "salesf" : salesFlag, "callbackf" : callbackFlag, "exclusionf" : exclusionFlag, "callBackNumber" : callBackNumber, "callBackType" : callBackType, "callBackDateTime" : callBackDateTime, "snoozeValue" : 0};
			dispositons = {"failedDisposeStatus" : "Succes"};
	    	stringdisp = JSON.stringify(dispositons);
		    $.ajax({
		        type: "POST",
		        url: "portal",
		        data: data,
		        dataType: 'json',
		        //async: false,
		        success: function(response) {
		        	stopDisposeTimer();
		        	responseJSON = JSON.parse(JSON.stringify(response));
		        	statsDetails = responseJSON["AgentStatsDetails"];
		        	isActive = false;
		        	if(statsDetails["updateStatus"] == "Success" && statsDetails != null) {
			         
						$("#customerTable").html("");
		        		$("#customerTable").show();
		        		$("#customerTable").append('<div style="height: 387px; line-height: 350px;">' + 
			    		'<h1 id="customerBody" style="color: green; text-align: center; font-size: 50px;">Waiting For Call</h1>' +
			    		'</div>');
		        		$("#navigationtabs").html("");
		        		$("#navigationtabs").hide();
		        		$("#processTable").hide();
		        	//	$("#historyshowdata").html("");
		        	//	$("#historydata").hide();
		        		// Added on 16-11-2017
		        		$("#bottomdiv").show();
		        		$("#agentscriptslinks").hide();
		        		// Added on 24-03-2017 LCS
		        		$("#lcstabdata").html();
		        		$("#lcstabdata").hide();
		        		// Ended
		        		
		        		$("#agentRemarks").val("");
		        		$("#callBackNumber").val("");
		        		$("#disposition").html("");
		        		// Added on 16-11-2017
		        		$("#disposition").append('<option id="159" data="THPY" value="Third Party">Third Party</option>');
						$("#subDisposition").html("");
						$("#callBackType").html("");
						$("#callbackdatetimepicker").val("");
						$('#bottomdiv input[type="radio"]').each(function () { 
							 $(this).prop('checked', false); 
						});
					//	$("#language").html("");
		        		
		        		CustomerDetails = "";
						LOBDetails = "";
						AgentScriptDetails = "";
						labelMapDetails = "";
						orderMapDetails = "";
						subProcessDetails = "";
						processDetails = "";
						// Added on 24-03-2017 LCS
						lcsDetails = "";
						
		        	} else {
		        		stopDisposeTimer();
		        		$("#customerTable").html("");
		        		$("#customerTable").show();
		        		$("#customerTable").append('<div style="height: 387px; line-height: 350px;">' + 
			    		'<h1 id="customerBody" style="color: green; text-align: center; font-size: 50px;">Waiting For Call</h1>' +
			    		'<h2 style="color :red; text-align: center; margin-top:-335px">Data Save Failed</h2>' +
			    		'</div>');
		        		$("#navigationtabs").html("");
		        		$("#navigationtabs").hide();
		        		$("#processTable").hide();
		        	//	$("#historyshowdata").html("");
		        	//	$("#historydata").hide();
		        		$("#agentscriptslinks").hide();
		        		// Added on 16-11-2017
		        		$("#bottomdiv").show();
		        		// Added on 24-03-2017 LCS
		        		$("#lcstabdata").html();
		        		$("#lcstabdata").hide();
		        		// Ended
		        		
		        		$("#agentRemarks").val("");
		        		$("#callBackNumber").val("");
		        		$("#disposition").html("");
		        		// Added on 16-11-2017
		        		$("#disposition").append('<option id="159" data="THPY" value="Third Party">Third Party</option>');
						$("#subDisposition").html("");
						$("#callBackType").html("");
						$("#callbackdatetimepicker").val("");
						$('#bottomdiv input[type="radio"]').each(function () { 
							 $(this).prop('checked', false); 
						});
					//	$("#language").html("");
		        		
		        		CustomerDetails = "";
						LOBDetails = "";
						AgentScriptDetails = "";
						labelMapDetails = "";
						orderMapDetails = "";
						subProcessDetails = "";
						processDetails = "";
						// Added on 24-03-2017 LCS
						lcsDetails = "";
		        	} 
		        },
		        error: function(e) {
		        }
			});
	      	return stringdisp;
		}
		
		function replaceChars(replaceString) {
			return replaceString.replace(/[&%]/gi, '');
		}
		
	 
		
		function appletautodispose(jsonCallDispObject) {
			
			// Added on 11-07-0217
			var jsDate = new Date();
	    	var jsLogDateTime = (jsDate.getDate() < 10 ? "0" + jsDate.getDate() : jsDate.getDate())  + "-" + ((jsDate.getMonth()) < 10 ? "0" + (jsDate.getMonth() + 1) : jsDate.getMonth() + 1) + "-" + jsDate.getFullYear() + " " + jsDate.getHours() + ":" + jsDate.getMinutes() + ":" + (jsDate.getSeconds() < 10 ? "0" + jsDate.getSeconds() : jsDate.getSeconds());
	    	writeFile.WriteLine(jsLogDateTime + " : Auto Dispose Call Details : " + jsonCallDispObject);
			// Ended
			
			var jsonCallDispParse = "";
			
			var agentName = "";
			var agentID = "";
			
			var processID = 0;
			var subProcessID = 0;
			var isDispose = false;
			
	    	var agentRemarks = "";
	    	var dispositionID = 0;
	    	var dispositionCode = "";
	    	var disposition = "";
			var subDispositionID = 0;
			var subDispositionCode = "";
			var subDisposition = "";
	    	var callbackFlag = 0;
	    	var salesFlag = 0;
	    	var exclusionFlag = 0;
	    	var category = "";
	    	
	    	var callBackNumber = "";
			var callBackType = "";
			var callBackDateTime = "";
			var language = "";
			var date = "";
			
			var dispositons = "";
			var stringdisp= "";
			
			var idleTime = 0;
			var talkTime = 0;
			var wrapTime = 0;
			var holdTime = 0;
			var previewTime = 0;
			var callStartTime = "";
			var callEndTime = "";
			
			var currDate = new Date();
			var dt = currDate.getDate();
		    var month = currDate.getMonth() + 1; 
		    var year = currDate.getFullYear();
		    if(dt < 10) {
		    	dt = '0' + dt;
			} 
			if(month < 10) {
			    month = '0' + month;
			}
			date = year + "-" + month + "-" + dt;
			
			// Added on 24-03-2017 LCS
			var lcsTokenNo = "";
			
			if(jsonCallDispObject != null && jsonCallDispObject != "" && typeof jsonCallDispObject !== "undefined") {
    			jsonCallDispParse = JSON.parse(jsonCallDispObject);
    		}
			if(jsonCallDispParse != null && jsonCallDispParse != "" && typeof jsonCallDispParse !== "undefined") {
				if(jsonCallDispParse["isDispose"] != "" && jsonCallDispParse["isDispose"] != null && typeof jsonCallDispParse["isDispose"] !== "undefined") {
					isDispose = jsonCallDispParse["isDispose"];
				}
			}
			//agentRemarks = $("#agentRemarks").val();
			language = $("#language").val();
			
			if(processDetails != null && processDetails != "" &&  typeof processDetails !== "undefined") {
				processID = $("#lobInfo").attr("data");
			}
			if(subProcessDetails != null && subProcessDetails != "" &&  typeof subProcessDetails !== "undefined") {
				subProcessID = $("#subProcess").attr("data");
			}
			
			if(CustomerDetails == "" && LOBDetails == "" && AgentScriptDetails == "" && labelMapDetails == "" && orderMapDetails == "" && subProcessDetails == "" && processDetails == "") {
				var stringcbdisp = callbackAutoDispositionValidation(jsonCallDispObject);
				return stringcbdisp;
	    	} /* else {
	    		if(isDispose) {
	    			if(dispJsonArray != null && dispJsonArray != "" && typeof dispJsonArray !== "undefined") {
				    	for (var i = 0; i < dispJsonArray.length; i++) {
							if(jsonDisp[dispJsonArray[i]]["code"] == "Auto") {
								dispositionID = jsonDisp[dispJsonArray[i]]["dispid"];
								dispositionCode = jsonDisp[dispJsonArray[i]]["code"];
								disposition = jsonDisp[dispJsonArray[i]]["description"];
								agentRemarks = disposition;
								callbackFlag = jsonDisp[dispJsonArray[i]]["callbackf"];
								salesFlag = jsonDisp[dispJsonArray[i]]["salesf"];
						    	exclusionFlag = jsonDisp[dispJsonArray[i]]["exclusionf"];
							}
						}
			    	}
	    		}
			}  */
	    	if(isDispose) {
			var callDetailsXmlData = "";
			var td1 = "";
			var td2 = "";
			var td3 = "";
			var td4 = "";
			var labelName1 = "";
			var labelValue1 = "";
			var labelName2 = "";
			var labelValue2 = "";
			
			agentName = $("#agentName").val();
			agentID = agentName;
			
			var tempCustomerID = 0;
			var batchID = 0;
			if(CustomerDetails != null && CustomerDetails != "" && typeof CustomerDetails !== "undefined") {
				tempCustomerID = CustomerDetails["CUSTOMERID"];
				batchID = CustomerDetails["BATCHID"];
			}
			
			var processxmlData = "<ROOT><PROCESS><FLDCUSTOMERID>" + tempCustomerID +"</FLDCUSTOMERID>";
			var tableRow = $("#processTable").find("tr");
			var processLength = tableRow.length;
			for(var i = 0; i < processLength; i++) {
				td1 = tableRow.eq(i).find('td:eq(0)');
				td2 = tableRow.eq(i).find('td:eq(1)');
				td3 = tableRow.eq(i).find('td:eq(2)');
				td4 = tableRow.eq(i).find('td:eq(3)');
				
				if(td1 != null && td1 != "" && typeof td1 !== "undefined") {
					if(td1.find("label").attr("id") != null && typeof td1.find("label").attr("id") !== "undefined" && td1.find("label").attr("id") != "")
						labelName1 = td1.find("label").attr("id");
				}
				if(td2 != null && td2 != "" && typeof td2 !== "undefined") {
					if(td2.find("input").val() != null && typeof td2.find("input").val() !== "undefined" && td2.find("input").val() != "") {
						labelValue1 = td2.find("input").val();
					} else if(td2.find("textarea").val() != null && typeof td2.find("textarea").val() !== "undefined" && td2.find("textarea").val() != "") {
						labelValue1 = td2.find("textarea").val();
					} else if(td2.find("select").val() != null && typeof td2.find("select").val() !== "undefined" && td2.find("select").val() != "") {
						labelValue1 = td2.find("select").val();
					}
				}
				
				if(td3 != null && td3 != "" && typeof td3 !== "undefined") {
					if(td3.find("label").attr("id") != null && typeof td3.find("label").attr("id") !== "undefined" && td3.find("label").attr("id") != "")
						labelName2 = td3.find("label").attr("id");
				}
				if(td4 != null && td4 != "" && typeof td4 !== "undefined") {
					if(td4.find("input").val() != null && typeof td4.find("input").val() !== "undefined" && td4.find("input").val() != "") {
						labelValue2 = td4.find("input").val();
					} else if(td4.find("textarea").val() != null && typeof td4.find("textarea").val() !== "undefined" && td4.find("textarea").val() != "") {
						labelValue2 = td4.find("textarea").val();
					} else if(td4.find("select").val() != null && typeof td4.find("select").val() !== "undefined" && td4.find("select").val() != "") {
						labelValue2 = td4.find("select").val();
					}
				}
				if((labelName1 != "" && labelValue1 != "") && (typeof labelName1 !== "undefined" && typeof labelValue1 !== "undefined") && (labelName1 != null && labelValue1 != null)) {
					processxmlData += "<" + labelName1 + "><![CDATA[" + replaceChars(labelValue1) + "]]></" + labelName1 + ">";
					labelName1 = "";
					labelValue1 = "";
				}
				if((labelName2 != "" && labelValue2 != "") && (typeof labelName2 !== "undefined" && typeof labelValue2 !== "undefined") && (labelName2 != null && labelValue2 != null)) {
					processxmlData += "<" + labelName2 + "><![CDATA[" + replaceChars(labelValue2) + "]]></" + labelName2 + ">";
					labelName2 = "";
					labelValue2 = "";
				}
			}
			processxmlData += "</PROCESS>";
			processxmlData += "</ROOT>";
			
			if(jsonCallDispParse != null && jsonCallDispParse != "" && typeof jsonCallDispParse !== "undefined") {
				if(jsonCallDispParse["dialNumber"] != "" && jsonCallDispParse["dialNumber"] != null && typeof jsonCallDispParse["dialNumber"] !== "undefined") {
					dialNumber = jsonCallDispParse["dialNumber"];
				}
				if(jsonCallDispParse["idleTime"] != "" && jsonCallDispParse["idleTime"] != null && typeof jsonCallDispParse["idleTime"] !== "undefined") {
					idleTime = jsonCallDispParse["idleTime"];
				}
				if(jsonCallDispParse["talkTime"] != "" && jsonCallDispParse["talkTime"] != null && typeof jsonCallDispParse["talkTime"] !== "undefined") {
					talkTime = jsonCallDispParse["talkTime"];
				}
				if(jsonCallDispParse["wrapTime"] != "" && jsonCallDispParse["wrapTime"] != null && typeof jsonCallDispParse["wrapTime"] !== "undefined") {
					wrapTime = jsonCallDispParse["wrapTime"];
				}
				if(jsonCallDispParse["holdTime"] != "" && jsonCallDispParse["holdTime"] != null && typeof jsonCallDispParse["holdTime"] !== "undefined") {
					holdTime = jsonCallDispParse["holdTime"];
				}
				if(jsonCallDispParse["previewTime"] != "" && jsonCallDispParse["previewTime"] != null && typeof jsonCallDispParse["previewTime"] !== "undefined") {
					previewTime = jsonCallDispParse["previewTime"];
				}
				if(jsonCallDispParse["callStartTime"] != "" && jsonCallDispParse["callStartTime"] != null && typeof jsonCallDispParse["callStartTime"] !== "undefined") {
					callStartTime = jsonCallDispParse["callStartTime"];
				}
				if(jsonCallDispParse["callEndTime"] != "" && jsonCallDispParse["callEndTime"] != null && typeof jsonCallDispParse["callEndTime"] !== "undefined") {
					callEndTime = jsonCallDispParse["callEndTime"];
				}
				// Added on 24-03-2017 LCS
				if(jsonCallDispParse["lcsTokenNo"] != "" && jsonCallDispParse["lcsTokenNo"] != null && typeof jsonCallDispParse["lcsTokenNo"] !== "undefined") {
					lcsTokenNo = jsonCallDispParse["lcsTokenNo"];
				}
				// Ended
				if(jsonCallDispParse["sequenceNumber"] != "" && jsonCallDispParse["sequenceNumber"] != null && typeof jsonCallDispParse["sequenceNumber"] !== "undefined") {
					recordingSeq = jsonCallDispParse["sequenceNumber"];
				} else {
					recordingSeq = sequenceNumber;
				}
			}
			
			disposition = $("#disposition").val();
			agentRemarks = $("#agentRemarks").val();
	    	if(disposition != null && disposition != "" && typeof disposition !== "undefined") {
	    		dispositionID = $("#disposition option:selected").attr("id");
				dispositionCode = $("#disposition option:selected").attr("data");
				if(dispJsonArray != null && dispJsonArray != "" && typeof dispJsonArray !== "undefined") {
			    	for (var i = 0; i < dispJsonArray.length; i++) {
						if(jsonDisp[dispJsonArray[i]]["code"] == dispositionCode) {
							callbackFlag = jsonDisp[dispJsonArray[i]]["callbackf"];
							salesFlag = jsonDisp[dispJsonArray[i]]["salesf"];
					    	exclusionFlag = jsonDisp[dispJsonArray[i]]["exclusionf"];
					    	break;
						}
					}
		    	}
	    	} else if(talkTime > 0) {
	    		if(dispJsonArray != null && dispJsonArray != "" && typeof dispJsonArray !== "undefined") {
			    	for (var i = 0; i < dispJsonArray.length; i++) {
						if(jsonDisp[dispJsonArray[i]]["code"] == "Auto") {
							dispositionID = jsonDisp[dispJsonArray[i]]["dispid"];
							dispositionCode = jsonDisp[dispJsonArray[i]]["code"];
							disposition = jsonDisp[dispJsonArray[i]]["description"];
							agentRemarks = disposition;
							callbackFlag = jsonDisp[dispJsonArray[i]]["callbackf"];
							salesFlag = jsonDisp[dispJsonArray[i]]["salesf"];
					    	exclusionFlag = jsonDisp[dispJsonArray[i]]["exclusionf"];
					    	break;
						}
					}
		    	}
	    	} else {
	    		if(dispJsonArray != null && dispJsonArray != "" && typeof dispJsonArray !== "undefined") {
			    	for (var i = 0; i < dispJsonArray.length; i++) {
						if(jsonDisp[dispJsonArray[i]]["code"] == "AUTONC") {
							dispositionID = jsonDisp[dispJsonArray[i]]["dispid"];
							dispositionCode = jsonDisp[dispJsonArray[i]]["code"];
							disposition = jsonDisp[dispJsonArray[i]]["description"];
							agentRemarks = disposition;
							callbackFlag = jsonDisp[dispJsonArray[i]]["callbackf"];
							salesFlag = jsonDisp[dispJsonArray[i]]["salesf"];
					    	exclusionFlag = jsonDisp[dispJsonArray[i]]["exclusionf"];
					    	break;
						}
					}
		    	}
	    	}
			
			//recordingSeq = sequenceNumber;
			
			callDetailsXmlData += "<ROOT><CALLDETAILS>" +
			"<FLDCUSTOMERID>" + tempCustomerID + "</FLDCUSTOMERID>" +
			"<FLDBATCHID>" + batchID + "</FLDBATCHID>" +
			"<FLDAGENTNAME>" + agentName + "</FLDAGENTNAME>" +
			"<FLDAGENTID>" + agentID + "</FLDAGENTID>" +
			"<FLDCALLID>" + callID + "</FLDCALLID>" +
			"<FLDDIALLEDNUMBER>" + dialNumber + "</FLDDIALLEDNUMBER>" +
			"<FLDIDLETIME>" + idleTime + "</FLDIDLETIME>" +
			"<FLDTALKTIME>" + talkTime + "</FLDTALKTIME>" +
			"<FLDWRAPTIME>" + wrapTime + "</FLDWRAPTIME>" +
			"<FLDHOLDTIME>" + holdTime + "</FLDHOLDTIME>" +
			"<FLDPREVIEWTIME>" + previewTime + "</FLDPREVIEWTIME>" +
			"<FLDCALLSTARTTIME>" + callStartTime + "</FLDCALLSTARTTIME>" +
			"<FLDCALLENDTIME>" + callEndTime + "</FLDCALLENDTIME>" +
			"<FLDPROCESSID>" + processID + "</FLDPROCESSID>" +
			"<FLDSUBPROCESSID>" + subProcessID + "</FLDSUBPROCESSID>" +
			"<FLDAGENTREMARKS><![CDATA[" + replaceChars(agentRemarks) +"]]></FLDAGENTREMARKS>" +
			"<FLDDISPOSITIONID>" + dispositionID + "</FLDDISPOSITIONID>" +
			"<FLDDISPOSITIONCODE>" + dispositionCode + "</FLDDISPOSITIONCODE>" +
			"<FLDDISPOSITION>" + disposition + "</FLDDISPOSITION>" +
			"<FLDSUBDISPOSITION>" + subDisposition + "</FLDSUBDISPOSITION>" +
			"<FLDSUBDISPOSITIONCODE>" + subDispositionCode + "</FLDSUBDISPOSITIONCODE>" +
			"<DISPCALLBACKFLAG>" + callbackFlag + "</DISPCALLBACKFLAG>" +
			"<FLDCALLBACKNUMBER>" + callBackNumber + "</FLDCALLBACKNUMBER>" +
			"<FLDCALLBACKTYPE>" + callBackType + "</FLDCALLBACKTYPE>" +
			"<FLDCALLBACKDATE>" + callBackDateTime + "</FLDCALLBACKDATE>" +
			"<FLDLANGUAGE>" + language + "</FLDLANGUAGE>" +
			"<FLDDATE>" + date + "</FLDDATE>" +
			"<FLDSERVICEID>" + serviceID + "</FLDSERVICEID>" +
			"<FLDSERVICENAME>" + serviceName + "</FLDSERVICENAME>" +
			"<FLDCALLTABLE>" + tableName + "</FLDCALLTABLE>" +
			"<FLDAGENTINDEX>" + agentIndex + "</FLDAGENTINDEX>" +
			"<FLDAUTORECORDING>" + autoRecording + "</FLDAUTORECORDING>" +
			"<FLDFILENAME>" + fileName + "</FLDFILENAME>" +
			"<FLDMEDIATYPE>" + mediaType + "</FLDMEDIATYPE>" +
			"<FLDRECINDEX>" + recordingIndex + "</FLDRECINDEX>" +
			"<FLDRECRATE>" + recordingRate + "</FLDRECRATE>" +
			"<FLDRECSEQ>" + recordingSeq + "</FLDRECSEQ>" +
			"<FLDRECSTATE>" + recordingState + "</FLDRECSTATE>" +
			"<FLDRECSTOREID>" + recordingStoreID + "</FLDRECSTOREID>" +
			"<FLDLCSTOKENNO>" + lcsTokenNo + "</FLDLCSTOKENNO>" + // Added on 24-03-2017 LCS
			"</CALLDETAILS></ROOT>";
			
			// Added on 11-07-0217
			var jsDate = new Date();
	    	var jsLogDateTime = (jsDate.getDate() < 10 ? "0" + jsDate.getDate() : jsDate.getDate())  + "-" + ((jsDate.getMonth()) < 10 ? "0" + (jsDate.getMonth() + 1) : jsDate.getMonth() + 1) + "-" + jsDate.getFullYear() + " " + jsDate.getHours() + ":" + jsDate.getMinutes() + ":" + (jsDate.getSeconds() < 10 ? "0" + jsDate.getSeconds() : jsDate.getSeconds());
	    	writeFile.WriteLine(jsLogDateTime + " : Auto Dispose Process Xml Data : " + processxmlData);
	    	writeFile.WriteLine(jsLogDateTime + " : Auto Dispose CallDetails Xml Data : " + callDetailsXmlData);
			// Ended
			
			var data = "opcode=customerupdate&processXml=" + processxmlData + "&callDetailsXml=" + callDetailsXmlData;
			dispositons = {"seqNum" : recordingSeq, "dispID" : dispositionID, "dispCode" : dispositionCode, "dispDesc" : disposition, "salesf" : salesFlag, "callbackf" : callbackFlag, "exclusionf" : exclusionFlag, "callBackNumber" : callBackNumber, "callBackType" : callBackType, "callBackDateTime" : callBackDateTime, "snoozeValue" : 0};
			stringdisp = JSON.stringify(dispositons);
		    $.ajax({
		        type: "POST",
		        url: "portal",
		        data: data,
		        dataType: 'json',
		       // async: false,
		        success: function(response) {
		        	// Added on 11-07-0217
		        	var jsDate = new Date();
	    			var jsLogDateTime = (jsDate.getDate() < 10 ? "0" + jsDate.getDate() : jsDate.getDate())  + "-" + ((jsDate.getMonth()) < 10 ? "0" + (jsDate.getMonth() + 1) : jsDate.getMonth() + 1) + "-" + jsDate.getFullYear() + " " + jsDate.getHours() + ":" + jsDate.getMinutes() + ":" + (jsDate.getSeconds() < 10 ? "0" + jsDate.getSeconds() : jsDate.getSeconds());
		        	writeFile.WriteLine(jsLogDateTime + " : appletautodispose Success : " + JSON.stringify(response));
		        	// Ended
		        	stopDisposeTimer();
		        	responseJSON = JSON.parse(JSON.stringify(response));
		        	statsDetails = responseJSON["AgentStatsDetails"];
		        	isActive = false;
		        	if(statsDetails["updateStatus"] == "Success" && statsDetails != null) {
			        	$("#leads").val(statsDetails["LEADS"] != "" ? statsDetails["LEADS"] : 0);
			        	$("#notcontact").val(statsDetails["NOTCONTACT"] != "" ? statsDetails["NOTCONTACT"] : 0);
						$("#rpc").val(statsDetails["RIGHTPARTYCONTACT"] != "" ? statsDetails["RIGHTPARTYCONTACT"] : 0);
						$("#cd").val(statsDetails["CALLDISCONNECT"] != "" ? statsDetails["CALLDISCONNECT"] : 0);
						$("#cb").val(statsDetails["CALLBACK"] != "" ? statsDetails["CALLBACK"] : 0);
						$("#tpc").val(statsDetails["THIRDPARTYCONTACT"] != "" ? statsDetails["THIRDPARTYCONTACT"] : 0);
						$("#successful").val(statsDetails["SUCCESSFULL"] != "" ? statsDetails["SUCCESSFULL"] : 0);
						$("#leadCallBack").val(statsDetails["LEADCALLBACK"] != "" ? statsDetails["LEADCALLBACK"] : 0);
						$("#autoWrap").val(statsDetails["AUTOWRAP"] != "" ? statsDetails["AUTOWRAP"] : 0);
						$("#totalcalls").val(statsDetails["TOTALCALLS"] != "" ? statsDetails["TOTALCALLS"] : 0);
						$("#loginHours").val(statsDetails["LOGINHOURS"] != "" ? statsDetails["LOGINHOURS"] : "00:00:00");
						$("#auxtime").val(statsDetails["AUXTIME"] != "" ? statsDetails["AUXTIME"] : "00:00:00");
						$("#lunch").val(statsDetails["LUNCH"] != "" ? statsDetails["LUNCH"] : "00:00:00");
						$("#teabreak").val(statsDetails["TEABREAK"] != "" ? statsDetails["TEABREAK"] : "00:00:00");
						$("#personalBreak").val(statsDetails["PERSONAL"] != "" ? statsDetails["PERSONAL"] : "00:00:00");
						$("#productiveTime").val(statsDetails["PRODUCTIVETIME"] != "" ? statsDetails["PRODUCTIVETIME"] : "00:00:00");
						$("#others").val(statsDetails["OTHERS"] != "" ? statsDetails["OTHERS"] : "00:00:00"); 
						
						$("#customerTable").html("");
		        		$("#customerTable").show();
		        		$("#customerTable").append('<div style="height: 387px; line-height: 350px;">' + 
			    		'<h1 id="customerBody" style="color: green; text-align: center; font-size: 50px;">Waiting For Call</h1>' +
			    		'</div>');
		        		$("#navigationtabs").html("");
		        		$("#navigationtabs").hide();
		        		$("#processTable").hide();
		        	//	$("#historyshowdata").html("");
		        	//	$("#historydata").hide();
		        		// Added on 16-11-2017
		        		$("#bottomdiv").show();
		        		$("#agentscriptslinks").hide();
		        		// Added on 24-03-2017 LCS
		        		$("#lcstabdata").html();
		        		$("#lcstabdata").hide();
		        		// Ended
		        		
		        		$("#agentRemarks").val("");
		        		$("#callBackNumber").val("");
		        		$("#disposition").html("");
		        		// Added on 16-11-2017
		        		$("#disposition").append('<option id="159" data="THPY" value="Third Party">Third Party</option>');
						$("#subDisposition").html("");
						$("#callBackType").html("");
						$("#callbackdatetimepicker").val("");
						$('#bottomdiv input[type="radio"]').each(function () { 
							 $(this).prop('checked', false); 
						});
					//	$("#language").html("");
		        		
		        		CustomerDetails = "";
						LOBDetails = "";
						AgentScriptDetails = "";
						labelMapDetails = "";
						orderMapDetails = "";
						subProcessDetails = "";
						processDetails = "";
						// Added on 24-03-2017 LCS
						lcsDetails = "";
						
		        	} else {
		        		stopDisposeTimer();
		        		$("#customerTable").html("");
		        		$("#customerTable").show();
		        		$("#customerTable").append('<div style="height: 387px; line-height: 350px;">' + 
			    		'<h1 id="customerBody" style="color: green; text-align: center; font-size: 50px;">Waiting For Call</h1>' +
			    		'<h2 style="color :red; text-align: center; margin-top:-335px">Data Save Failed</h2>' +
			    		'</div>');
		        		$("#navigationtabs").html("");
		        		$("#navigationtabs").hide();
		        		$("#processTable").hide();
		        	//	$("#historyshowdata").html("");
		        	//	$("#historydata").hide();
		        		$("#agentscriptslinks").hide();
		        		// Added on 16-11-2017
		        		$("#bottomdiv").show();
		        		// Added on 24-03-2017 LCS
		        		$("#lcstabdata").html();
		        		$("#lcstabdata").hide();
		        		// Ended
		        		
		        		$("#agentRemarks").val("");
		        		$("#callBackNumber").val("");
		        		$("#disposition").html("");
		        		// Added on 16-11-2017
		        		$("#disposition").append('<option id="159" data="THPY" value="Third Party">Third Party</option>');
						$("#subDisposition").html("");
						$("#callBackType").html("");
						$("#callbackdatetimepicker").val("");
						$('#bottomdiv input[type="radio"]').each(function () { 
							 $(this).prop('checked', false); 
						});
					//	$("#language").html("");
		        		
		        		CustomerDetails = "";
						LOBDetails = "";
						AgentScriptDetails = "";
						labelMapDetails = "";
						orderMapDetails = "";
						subProcessDetails = "";
						processDetails = "";
						// Added on 24-03-2017 LCS
						lcsDetails = "";
		        	} 
		        },
		        error: function(xhr, status, error) {
		        	// Added on 11-07-0217		
		        	var jsDate = new Date();
	    			var jsLogDateTime = (jsDate.getDate() < 10 ? "0" + jsDate.getDate() : jsDate.getDate())  + "-" + ((jsDate.getMonth()) < 10 ? "0" + (jsDate.getMonth() + 1) : jsDate.getMonth() + 1) + "-" + jsDate.getFullYear() + " " + jsDate.getHours() + ":" + jsDate.getMinutes() + ":" + (jsDate.getSeconds() < 10 ? "0" + jsDate.getSeconds() : jsDate.getSeconds());
				    writeFile.WriteLine(jsLogDateTime + " : Status : " + status + " Error : " + error);
		        	// Ended
		        }
			});
	      } 
	      return stringdisp;
		}
		
		function callbackAutoDispositionValidation(jsonCallDispObject) {
			var jsonCallDispParse= "";
			
			var agentName = "";
			var agentID = "";
			var isDispose = false;
			
			var processID = 0;
			var subProcessID = 0;
			
			var agentRemarks = "";
	    	var dispositionID = 0;
	    	var dispositionCode = "";
	    	var disposition = "";
			var subDispositionID = 0;
			var subDispositionCode = "";
			var subDisposition = "";
	    	var callbackFlag = 0;
	    	var salesFlag = 0;
	    	var exclusionFlag = 0;
	    	var category = "";
	    	
	    	var callBackNumber = "";
			var callBackType = "";
			var callBackDateTime = "";
			var language = "";
			
			var date = "";
			var currDate = new Date();
			var dt = currDate.getDate();
		    var month = currDate.getMonth() + 1; 
		    var year = currDate.getFullYear();
		    if(dt < 10) {
		    	dt = '0' + dt;
			} 
			if(month < 10) {
			    month = '0' + month;
			}
			date = year + "-" + month + "-" + dt;
			
			var idleTime = 0;
			var talkTime = 0;
			var wrapTime = 0;
			var holdTime = 0;
			var previewTime = 0;
			var callStartTime = "";
			var callEndTime = "";
			
			var subdispoptioncount = 0;
			var callbackTypeCount = 0;
			var dispositons = "";
			var stringdisp= "";
			
			if(jsonCallDispObject != null && jsonCallDispObject != "" && typeof jsonCallDispObject !== "undefined") {
    			jsonCallDispParse = JSON.parse(jsonCallDispObject);
    		}
			if(jsonCallDispParse != null && jsonCallDispParse != "" && typeof jsonCallDispParse !== "undefined") {
				if(jsonCallDispParse["isDispose"] != "" && jsonCallDispParse["isDispose"] != null && typeof jsonCallDispParse["isDispose"] !== "undefined") {
					isDispose = jsonCallDispParse["isDispose"];
				}
			}
			//agentRemarks = $("#agentRemarks").val();
			language = $("#language").val();
			
			if(isDispose) {
				if(dispJsonArray != null && dispJsonArray != "" && typeof dispJsonArray !== "undefined") {
			    	for (var i = 0; i < dispJsonArray.length; i++) {
						if(jsonDisp[dispJsonArray[i]]["code"] == "Auto") {
							dispositionID = jsonDisp[dispJsonArray[i]]["dispid"];
							dispositionCode = jsonDisp[dispJsonArray[i]]["code"];
							disposition = jsonDisp[dispJsonArray[i]]["description"];
							agentRemarks = disposition;
							callbackFlag = jsonDisp[dispJsonArray[i]]["callbackf"];
							salesFlag = jsonDisp[dispJsonArray[i]]["salesf"];
					    	exclusionFlag = jsonDisp[dispJsonArray[i]]["exclusionf"];
						}
					}
		    	}
			} 
	    	if(isDispose) {
				var callDetailsXmlData = "";
				var td1 = "";
				var td2 = "";
				var td3 = "";
				var td4 = "";
				var labelName1 = "";
				var labelValue1 = "";
				var labelName2 = "";
				var labelValue2 = "";
				
				agentName = $("#agentName").val();
				agentID = agentName;
				
				var tempCustomerID = 0;
				var batchID = 0;
				if(CustomerDetails != null && CustomerDetails != "" && typeof CustomerDetails !== "undefined") {
					tempCustomerID = CustomerDetails["CUSTOMERID"];
					batchID = CustomerDetails["BATCHID"];
				}
				
				var processxmlData = "<ROOT><PROCESS><FLDCUSTOMERID>" + tempCustomerID +"</FLDCUSTOMERID>";
				processxmlData += "</PROCESS>";
				processxmlData += "</ROOT>";
				
				if(jsonCallDispParse != null && jsonCallDispParse != "" && typeof jsonCallDispParse !== "undefined") {
					if(jsonCallDispParse["dialNumber"] != "" && jsonCallDispParse["dialNumber"] != null && typeof jsonCallDispParse["dialNumber"] !== "undefined") {
						dialNumber = jsonCallDispParse["dialNumber"];
					}
					if(jsonCallDispParse["idleTime"] != "" && jsonCallDispParse["idleTime"] != null && typeof jsonCallDispParse["idleTime"] !== "undefined") {
						idleTime = jsonCallDispParse["idleTime"];
					}
					if(jsonCallDispParse["talkTime"] != "" && jsonCallDispParse["talkTime"] != null && typeof jsonCallDispParse["talkTime"] !== "undefined") {
						talkTime = jsonCallDispParse["talkTime"];
					}
					if(jsonCallDispParse["wrapTime"] != "" && jsonCallDispParse["wrapTime"] != null && typeof jsonCallDispParse["wrapTime"] !== "undefined") {
						wrapTime = jsonCallDispParse["wrapTime"];
					}
					if(jsonCallDispParse["holdTime"] != "" && jsonCallDispParse["holdTime"] != null && typeof jsonCallDispParse["holdTime"] !== "undefined") {
						holdTime = jsonCallDispParse["holdTime"];
					}
					if(jsonCallDispParse["previewTime"] != "" && jsonCallDispParse["previewTime"] != null && typeof jsonCallDispParse["previewTime"] !== "undefined") {
						previewTime = jsonCallDispParse["previewTime"];
					}
					if(jsonCallDispParse["callStartTime"] != "" && jsonCallDispParse["callStartTime"] != null && typeof jsonCallDispParse["callStartTime"] !== "undefined") {
						callStartTime = jsonCallDispParse["callStartTime"];
					}
					if(jsonCallDispParse["callEndTime"] != "" && jsonCallDispParse["callEndTime"] != null && typeof jsonCallDispParse["callEndTime"] !== "undefined") {
						callEndTime = jsonCallDispParse["callEndTime"];
					}
					if(jsonCallDispParse["sequenceNumber"] != "" && jsonCallDispParse["sequenceNumber"] != null && typeof jsonCallDispParse["sequenceNumber"] !== "undefined") {
						recordingSeq = jsonCallDispParse["sequenceNumber"];
					} else {
						recordingSeq = sequenceNumber;
					}
				}
				
				//recordingSeq = sequenceNumber;
				
				callDetailsXmlData += "<ROOT><CALLDETAILS>" +
				"<FLDCUSTOMERID>" + tempCustomerID + "</FLDCUSTOMERID>" +
				"<FLDBATCHID>" + batchID + "</FLDBATCHID>" +
				"<FLDAGENTNAME>" + agentName + "</FLDAGENTNAME>" +
				"<FLDAGENTID>" + agentID + "</FLDAGENTID>" +
				"<FLDCALLID>" + callID + "</FLDCALLID>" +
				"<FLDDIALLEDNUMBER>" + dialNumber + "</FLDDIALLEDNUMBER>" +
				"<FLDIDLETIME>" + idleTime + "</FLDIDLETIME>" +
				"<FLDTALKTIME>" + talkTime + "</FLDTALKTIME>" +
				"<FLDWRAPTIME>" + wrapTime + "</FLDWRAPTIME>" +
				"<FLDHOLDTIME>" + holdTime + "</FLDHOLDTIME>" +
				"<FLDPREVIEWTIME>" + previewTime + "</FLDPREVIEWTIME>" +
				"<FLDCALLSTARTTIME>" + callStartTime + "</FLDCALLSTARTTIME>" +
				"<FLDCALLENDTIME>" + callEndTime + "</FLDCALLENDTIME>" +
				"<FLDPROCESSID>" + processID + "</FLDPROCESSID>" +
				"<FLDSUBPROCESSID>" + subProcessID + "</FLDSUBPROCESSID>" +
				"<FLDAGENTREMARKS><![CDATA[" + replaceChars(agentRemarks) +"]]></FLDAGENTREMARKS>" +
				"<FLDDISPOSITIONID>" + dispositionID + "</FLDDISPOSITIONID>" +
				"<FLDDISPOSITIONCODE>" + dispositionCode + "</FLDDISPOSITIONCODE>" +
				"<FLDDISPOSITION>" + disposition + "</FLDDISPOSITION>" +
				"<FLDSUBDISPOSITION>" + subDisposition + "</FLDSUBDISPOSITION>" +
				"<FLDSUBDISPOSITIONCODE>" + subDispositionCode + "</FLDSUBDISPOSITIONCODE>" +
				"<DISPCALLBACKFLAG>" + callbackFlag + "</DISPCALLBACKFLAG>" +
				"<FLDCALLBACKNUMBER>" + callBackNumber + "</FLDCALLBACKNUMBER>" +
				"<FLDCALLBACKTYPE>" + callBackType + "</FLDCALLBACKTYPE>" +
				"<FLDCALLBACKDATE>" + callBackDateTime + "</FLDCALLBACKDATE>" +
				"<FLDLANGUAGE>" + language + "</FLDLANGUAGE>" +
				"<FLDDATE>" + date + "</FLDDATE>" +
				"<FLDSERVICEID>" + serviceID + "</FLDSERVICEID>" +
				"<FLDSERVICENAME>" + serviceName + "</FLDSERVICENAME>" +
				"<FLDCALLTABLE>" + tableName + "</FLDCALLTABLE>" +
				"<FLDAGENTINDEX>" + agentIndex + "</FLDAGENTINDEX>" +
				"<FLDAUTORECORDING>" + autoRecording + "</FLDAUTORECORDING>" +
				"<FLDFILENAME>" + fileName + "</FLDFILENAME>" +
				"<FLDMEDIATYPE>" + mediaType + "</FLDMEDIATYPE>" +
				"<FLDRECINDEX>" + recordingIndex + "</FLDRECINDEX>" +
				"<FLDRECRATE>" + recordingRate + "</FLDRECRATE>" +
				"<FLDRECSEQ>" + recordingSeq + "</FLDRECSEQ>" +
				"<FLDRECSTATE>" + recordingState + "</FLDRECSTATE>" +
				"<FLDRECSTOREID>" + recordingStoreID + "</FLDRECSTOREID>" +
				"</CALLDETAILS></ROOT>";
				
				var data = "opcode=customerupdate&processXml=" + processxmlData + "&callDetailsXml=" + callDetailsXmlData;
				dispositons = {"seqNum" : recordingSeq, "dispID" : dispositionID, "dispCode" : dispositionCode, "dispDesc" : disposition, "salesf" : salesFlag, "callbackf" : callbackFlag, "exclusionf" : exclusionFlag, "callBackNumber" : callBackNumber, "callBackType" : callBackType, "callBackDateTime" : callBackDateTime, "snoozeValue" : 0};
				stringdisp = JSON.stringify(dispositons);
			    $.ajax({
			        type: "POST",
			        url: "portal",
			        data: data,
			        dataType: 'json',
			        //async: false,
			        success: function(response) {
			        	stopDisposeTimer();
			        	responseJSON = JSON.parse(JSON.stringify(response));
		        		statsDetails = responseJSON["AgentStatsDetails"];
		        		isActive = false;
			        	if(statsDetails["updateStatus"] == "Success" && statsDetails != null) {
				         
							$("#customerTable").html("");
			        		$("#customerTable").show();
			        		$("#customerTable").append('<div style="height: 387px; line-height: 350px;">' + 
				    		'<h1 id="customerBody" style="color: green; text-align: center; font-size: 50px;">Waiting For Call</h1>' +
				    		'</div>');
			        		$("#navigationtabs").html("");
			        		$("#navigationtabs").hide();
			        		$("#processTable").hide();
			        	//	$("#historyshowdata").html("");
			        	//	$("#historydata").hide();
			        		// Added on 16-11-2017
			        		$("#bottomdiv").show();
			        		$("#agentscriptslinks").hide();
			        		// Added on 24-03-2017 LCS
			        		$("#lcstabdata").html();
			        		$("#lcstabdata").hide();
			        		// Ended
			        		
			        		$("#agentRemarks").val("");
			        		$("#callBackNumber").val("");
			        		$("#disposition").html("");
			        		// Added on 16-11-2017
			        		$("#disposition").append('<option id="159" data="THPY" value="Third Party">Third Party</option>');
							$("#subDisposition").html("");
							$("#callBackType").html("");
							$("#callbackdatetimepicker").val("");
							$('#bottomdiv input[type="radio"]').each(function () { 
								 $(this).prop('checked', false); 
							});
						//	$("#language").html("");
			        		
			        		CustomerDetails = "";
							LOBDetails = "";
							AgentScriptDetails = "";
							labelMapDetails = "";
							orderMapDetails = "";
							subProcessDetails = "";
							processDetails = "";
							// Added on 24-03-2017 LCS
							lcsDetails = "";
							
			        	} else {
			        		stopDisposeTimer();
			        		$("#customerTable").html("");
			        		$("#customerTable").show();
			        		$("#customerTable").append('<div style="height: 387px; line-height: 350px;">' + 
				    		'<h1 id="customerBody" style="color: green; text-align: center; font-size: 50px;">Waiting For Call</h1>' +
				    		'<h2 id="dataerror" style="color :red; text-align: center; margin-top:-335px">Data Save Failed</h2>' +
				    		'</div>');
			        		$("#navigationtabs").html("");
			        		$("#navigationtabs").hide();
			        		$("#processTable").hide();
			        	//	$("#historyshowdata").html("");
			        	//	$("#historydata").hide();
			        		$("#agentscriptslinks").hide();
			        		// Added on 16-11-2017
			        		$("#bottomdiv").show();
			        		// Added on 24-03-2017 LCS
			        		$("#lcstabdata").html();
			        		$("#lcstabdata").hide();
			        		// Ended
			        		
			        		$("#agentRemarks").val("");
			        		$("#callBackNumber").val("");
			        		$("#disposition").html("");
			        		// Added on 16-11-2017
			        		$("#disposition").append('<option id="159" data="THPY" value="Third Party">Third Party</option>');
							$("#subDisposition").html("");
							$("#callBackType").html("");
							$("#callbackdatetimepicker").val("");
							$('#bottomdiv input[type="radio"]').each(function () { 
								 $(this).prop('checked', false); 
							});
						//	$("#language").html("");
			        		
			        		CustomerDetails = "";
							LOBDetails = "";
							AgentScriptDetails = "";
							labelMapDetails = "";
							orderMapDetails = "";
							subProcessDetails = "";
							processDetails = "";
							// Added on 24-03-2017 LCS
							lcsDetails = "";
			        	} 
			        },
			        error: function(e) {
			        }
				});
		      }
	    	return stringdisp;
		}
		
		function appletNotReady(notReadyJsonObject) {
			var agentName = "";
			var startTime = "";
			var endTime = "";
			var duration = 0;
			var reasoncode = "";
			var state = "NOT READY";
			var date = "";
			
			var jsonNotReadyParse = JSON.parse(notReadyJsonObject);
			if(jsonNotReadyParse != null && jsonNotReadyParse != "" && typeof jsonNotReadyParse !== "undefined") {
				startTime = jsonNotReadyParse["startTime"];
				endTime = jsonNotReadyParse["endTime"];
				duration = jsonNotReadyParse["duration"];
				reasoncode = jsonNotReadyParse["reasoncode"];
				state = jsonNotReadyParse["state"];
				date = jsonNotReadyParse["date"];
			}
			agentName = $("#agentName").val();
			var data = "opcode=insertnotreadydetails&agentName=" + agentName + "&startTime=" + startTime +
			"&endTime=" + endTime + "&duration=" + duration + "&reasoncode=" + reasoncode + "&state=" + state +
			"&date=" + startTime + "," + endTime;
			
			$.ajax({
		        type: "POST",
		        url: "portal",
		        data: data,
		        dataType: 'json',
		        success: function(response){
		        	responseJSON = JSON.parse(JSON.stringify(response));
		        	if(responseJSON["notReadyStatus"] == "SUCCESS") {
		        	} else {
		        	} 
		        },
		        error: function(e){
		        }
			});
		}
		function notReadyState(notReadyFlag) {
			if(notReadyFlag) {
				$("#customerTable").html("");
        		$("#customerTable").show();
        		$("#customerTable").append('<div style="height: 387px; line-height: 350px;">' + 
	    		'<h1 id="customerBody" style="color: orange; text-align: center; font-size: 50px;">Click Ready</h1>' +
	    		'</div>');
			}
		}
		function waitingState(waitFlag) {
			if(waitFlag) {
				$("#customerTable").html("");
        		$("#customerTable").show();
        		$("#bottomdiv").show(); // Added on 16-11-2017
        		$("#customerTable").append('<div style="height: 387px; line-height: 350px;">' + 
	    		'<h1 id="customerBody" style="color: green; text-align: center; font-size: 50px;">Waiting For Call</h1>' +
	    		'</div>');
			}
		}
		
		function loginapplet(flag, agentID,agentPassword, loginTime) {
	    	
	    	if(flag == true) {
	    		
	    		var agentName = "";
	    		var pattern = /[@]/;
	    		if(pattern.test(agentID)) {
	    			agentName = agentID.split("@")[0];
	    		} else {
	    			agentName = agentID;
	    		}
	    		
	    		// Added on 11-07-0217
	    		var activeObject = new ActiveXObject("Scripting.FileSystemObject");
	    		var jsDate = new Date();
	    		var date = (jsDate.getDate() < 10 ? "0" + jsDate.getDate() : jsDate.getDate())  + "-" + ((jsDate.getMonth()) < 10 ? "0" + (jsDate.getMonth() + 1) : jsDate.getMonth() + 1) + "-" + jsDate.getFullYear();
	    		var folderPath = jsLogPath + "\\" + agentName;
	    		if(activeObject.FolderExists(folderPath)) {
	    			writeFile = activeObject.OpenTextFile(folderPath + "\\" + jsLogFileName + "_" + date  + ".txt", 8, true);
	    		} else {
	    			activeObject.CreateFolder(folderPath);
	    		    writeFile = activeObject.CreateTextFile(folderPath + "\\" + jsLogFileName + "_" + date  + ".txt", true);
	    		}
	    		// Ended
	    		
	    		document.getElementById("divheadertable").style.display = "";
	    		document.getElementById("divappletbody").style.display = "";
	    		document.getElementById("divappletlogin").style.display = "none";
	    		document.getElementById("divlogoDisplay").style.display = "none";
	    		document.getElementById("loginFooter").style.display = "none";
	    		$("#agentName").val(agentName);
	    		 $.ajax({
			        type: "POST",
			        url: "portal",
			        data: "opcode=login&agentName=" + agentName + "&loginTime=" + loginTime+"&agentPassword="+agentPassword,
			        async: true,
			        dataType: 'json',
			        success: function(response) {
			        	var responseJSON = JSON.parse(JSON.stringify(response));
			        	var statsDetails = responseJSON["AgentStatsDetails"];
			        	$("#skey").val(responseJSON["ssoKeyForCRMNext"]);		
				       	if(statsDetails["agentStatsStatus"] == "Success" && statsDetails != null) {				       				       	
				        	 	$("#others").val(statsDetails["OTHERS"] != "" ? statsDetails["OTHERS"] : "00:00:00"); 
				       	}
			        	/* if(responseJSON != null && responseJSON["loginStatus"] == "SUCCESS") {
			        	} else {
			        	}  */
			        },
			        error: function(e){
			        }
				});
	    		
	    	} 
            return (flag);
        } 
		
		/**added by Vinay to show alert on 05-06-2018**/
		function showalertonwrap(){
			
			alert("Kindly wrap the call");
			window.focus();
		}
		
		function logoutapplet(flag, logoutTime, idleTime, notReadyJsonObject) {
			
			var jsonNotReadyParse = "";
			var startTime = "";
			var endTime = "";
			var duration = 0;
			var reasoncode = "";
			var state = "";
			var date = "";
			var data = "";
			
			if(scriptWindow != "" && scriptWindow != null && typeof scriptWindow !== "undefined" && !scriptWindow.closed) {
				scriptWindow.close();
			}
			
	    	if(flag == true) {
	    		if(notReadyJsonObject != null) {
	    			jsonNotReadyParse = JSON.parse(notReadyJsonObject);
	    			if(jsonNotReadyParse != null && jsonNotReadyParse != "" && typeof jsonNotReadyParse !== "undefined") {
						startTime = jsonNotReadyParse["startTime"];
						endTime = jsonNotReadyParse["endTime"];
						duration = jsonNotReadyParse["duration"];
						reasoncode = jsonNotReadyParse["reasoncode"];
						state = jsonNotReadyParse["state"];
						date = jsonNotReadyParse["date"];
						data = "opcode=logout&logoutTime=" + logoutTime + "&idleTime=" + idleTime +
						"&startTime=" + startTime + "&endTime=" + endTime + "&duration=" + duration + 
						"&reasoncode=" + reasoncode + "&state=" + state + "&date=" + startTime + "," + endTime;
					}
	    		} else {
	    			data = "opcode=logout&logoutTime=" + logoutTime + "&idleTime=" + idleTime + "&state=" + state;
	    		}
	    		
	    		$("#customerTable").html("");
	    		document.getElementById("divheadertable").style.display = "none";
	    		document.getElementById("divappletbody").style.display = "none";
	    		document.getElementById("divappletlogin").style.display = "none"; 
	    		$("#bottomdiv").hide();
				
				$.ajax({
			        type: "POST",
			        url: "portal",
			        data: data,
			        dataType: 'json',
			        async: false,
			        success: function(response) {
			        	responseJSON = JSON.parse(JSON.stringify(response));
			        	if(responseJSON != null && responseJSON["logoutStatus"] == "SUCCESS") {
			        		//window.close();
			        	} else {
			        		//window.close();
			        	} 
			        },
			        error: function(e){
			        }
				});
	    	}
	    	window.onbeforeunload = function() {
			};
	    	window.close();
        }
		
		$(document).ready(function() {
		 
			$("#phonenumber").keypress(function (e) {
				if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
					return false;
				}
				$("#phonenumber").val(dialNumber.replace(/\w(?=\w{4})/g, "X"));
			});
			
		
			//added on 2018-04-18 by vinay to handle copy paste and special char 
			
			var keyDown = false, ctrl = 17, vKey = 86, Vkey = 118;  
			$(document).on('keypress', 'input.numbercheck', function (e) {  
				var dataType = $(this).attr("data");
				if(dataType== "NUMBER"){
					if (!e) var e = window.event;  
					if (e.keyCode > 0 && e.which == 0) return true;  
                    if (e.keyCode) code = e.keyCode;  
                    else if (e.which) code = e.which;  
                    var character = String.fromCharCode(code);  
                    if (character == '\b' || character == ' ' || character == '\t') return true;  
                    if (keyDown && (code == vKey || code == Vkey)) return (character);  
                    else return (/[0-9]$/.test(character));  
                }
				if(dataType== "VARCHAR2"){
					if (!e) var e = window.event;  
					if (e.keyCode > 0 && e.which == 0) return true;  
                    if (e.keyCode) code = e.keyCode;  
                    if (e.keyCode == 13) return true;
                    else if (e.which) code = e.which;  
                    var character = String.fromCharCode(code);  
                    if (character == '\b' || character == ' ' || character == '\t') return true;  
                    if (keyDown && (code == vKey || code == Vkey)) return (character);  
                    else return (/[0-9A-Za-z =:&()+%,@._/]$/.test(character));  
                }
                
            }).on('focusout', 'input.numbercheck', function (e) {
				var dataType = $(this).attr("data");
				if(dataType == "NUMBER"){
					var $this = $(this);  
					$this.val($this.val().replace(/[^0-9]/g, ''));
				}
				if(dataType == "VARCHAR2"){
					var $this = $(this);  
					$this.val($this.val().replace(/[^0-9A-Za-z =:&()+%,@._/\n]/g, ''));
				}
                  
            }).on('paste', 'input.numbercheck', function (e) {  
				  var dataType = $(this).attr("data");
				if(dataType == "NUMBER"){
					var $this = $(this);  
					setTimeout(function () {  
						$this.val($this.val().replace(/[^0-9]/g, ''));  
					}, 5);
				}
				if(dataType == "VARCHAR2"){
					var $this = $(this);  
					setTimeout(function () {  
						$this.val($this.val().replace(/[^0-9A-Za-z =:&()+%,@._/\n]/g, ''));  
					}, 5);
				}
                  
            }); 
			
			/****** Text area******/
			$(document).on('keypress', 'textarea.numbercheck', function (e) {  
				var dataType = $(this).attr("data");
				if(dataType== "NUMBER"){
					if (!e) var e = window.event;  
					if (e.keyCode > 0 && e.which == 0) return true;  
                    if (e.keyCode) code = e.keyCode;  
                    else if (e.which) code = e.which;  
                    var character = String.fromCharCode(code);  
                    if (character == '\b' || character == ' ' || character == '\t') return true;  
                    if (keyDown && (code == vKey || code == Vkey)) return (character);  
                    else return (/[0-9]$/.test(character));  
                }
				if(dataType== "VARCHAR2"){
					if (!e) var e = window.event;  
					if (e.keyCode > 0 && e.which == 0) return true;  
                    if (e.keyCode) code = e.keyCode;  
                    else if (e.which) code = e.which; 
                    if (e.keyCode == 13) return true;
                    var character = String.fromCharCode(code);  
                    if (character == '\b' || character == ' ' || character == '\t') return true;  
                    if (keyDown && (code == vKey || code == Vkey)) return (character);  
                    else return (/[0-9A-Za-z =:&()+%,@._/]$/.test(character));  
                }
                
            }).on('focusout', 'textarea.numbercheck', function (e) {
				var dataType = $(this).attr("data");
				if(dataType == "NUMBER"){
					var $this = $(this);  
					$this.val($this.val().replace(/[^0-9]/g, ''));
				}
				if(dataType == "VARCHAR2"){
					var $this = $(this);  
					$this.val($this.val().replace(/[^0-9A-Za-z =:&()+%,@._/\n]/g, ''));
				}
                  
            }).on('paste', 'textarea.numbercheck', function (e) {  
				  var dataType = $(this).attr("data");
				if(dataType == "NUMBER"){
					var $this = $(this);  
					setTimeout(function () {  
						$this.val($this.val().replace(/[^0-9]/g, ''));  
					}, 5);
				}
				if(dataType == "VARCHAR2"){
					var $this = $(this);  
					setTimeout(function () {  
						$this.val($this.val().replace(/[^0-9A-Za-z =:&()+%,@._/\n]/g, ''));  
					}, 5);
				}
                  
            }); 
			
			$('#bottomdiv input[type="radio"]').click(function() {
 
				$("#callbackdatetimepicker").val("");
				//$("#callbackdatetimepicker").val();
				
				var callBackDateTime = "";
				snoozeValue = $(this).val();
				var d1 = new Date();
			    var currDate = new Date(d1);
			    currDate.setMinutes (d1.getMinutes() + parseInt(snoozeValue));
	            var date = currDate.getDate();
			    var month = currDate.getMonth() + 1; 
			    var year = currDate.getFullYear();
			    var hours = currDate.getHours();
			    var mins = currDate.getMinutes();
			    
				if(date < 10) {
				    date = '0' + date;
				} 
				if(month < 10) {
				    month = '0' + month;
				} 
				if(mins < 10) {
					mins = '0' + mins;
				} 
				
				callBackDateTime = year + "-" + month + "-" + date + " " + hours + ":" + mins;
				
	            $("#callbackdatetimepicker").val(callBackDateTime);
			});
			
			$("#disposition").change(function() {
				
				var callbackFlag = 0;
				var callBackType = "";
				var subDispValues = "";
				var subdispoptioncount = 0;
				var callbackTypeCount = 0;
				var selectedispValue = $("#disposition option:selected").val();
				var subProcessID = $("#subProcess").attr("data");
				
				if(selectedispValue != null && selectedispValue != "") {
					var selecteddispCode = $("#disposition option:selected").attr("data");
					var selecteddispID = $("#disposition option:selected").attr("id");
					$("#agentRemarks").val(selectedispValue);
					$("#subDisposition").html("");
					subDispValues = '<option value="">-- Select --</option>';
					if(subDispXml != null && subDispXml != "") {
						var xmlDoc = $.parseXML(subDispXml),
					    $xml = $(xmlDoc);
						$xml.find("ROW").each(function() {
							if($(this).find("DISPOSITIONCODE").text() == selecteddispCode) {
				    		   $(this).find("SUBDISPOSITION").each(function() {
				    			   if($(this).find("SUBPROCESSID").text() != null && $(this).find("SUBPROCESSID").text() != "") {
				    				   if($(this).find("SUBPROCESSID").text() == subProcessID) {
				    					   if($(this).find("SUBDISPOSITIONNAME").text() != null && $(this).find("SUBDISPOSITIONNAME").text() != "") {
						    				   subDispValues += '<option id="' + $(this).find("SUBDISPID").text() + '" data="' + $(this).find("SUBDISPOSITIONCODE").text() + '" value="' + $(this).find("SUBDISPOSITIONNAME").text() + '">' + $(this).find("SUBDISPOSITIONNAME").text() + '</option>';
						    			   }
				    				   }
				    			   	}
				    		   });
					    	}
						});
					}
					$("#subDisposition").append(subDispValues);
					
					$("#subDisposition option").each(function() {
			    		subdispoptioncount++;
			    	});
				 
					if(dispositionXml != null) {
						var dispXmlDoc = $.parseXML(dispositionXml);
						$(dispXmlDoc).find("ROW").each(function() {
		 					if($(this).find("DISPOSITIONCODE").text() == selecteddispCode) {
		 						callbackFlag = $(this).find("CALLBACKFLAG").text();
		 					}
		 				});
					}
					// Ended
					
					if(kvPairXml != "" && kvPairXml != null) {
						var kvPairXmlDoc = $.parseXML(kvPairXml);
					    $(kvPairXmlDoc).find("KVPLIST").each(function() {
							if($(this).find("KEY").text() == "CALLBACKTYPE") {
								callBackType = $(this).find("VALUE").text();
							}
						});
					}
					
					if(callbackFlag == 1) {
						var callBackNumber=$("#callBackNumber").val();
						//$("#callBackNumber").val(dialNumber.replace(/\w(?=\w{4})/g, "X"));
						$('#bottomdiv input[type="radio"]').each(function () { 
							$(this).attr("checked", false);
						});
						
						$("#callbackdatetimepicker").val("");
						$("#callBackNumber").removeClass("errorborder");
						$("#subDisposition").removeClass("errorborder");
						$("#callBackType").removeClass("errorborder");
						$("#callbackdatetimepicker").removeClass("errorborder");
						$("#callBackNumber").attr("disabled", false);
						if(subdispoptioncount > 1) {
							$("#subDisposition").attr("disabled", false);
				    	} else {
				    		$("#subDisposition").html("");
				    		$("#subDisposition").attr("disabled", true);
				    	}
						
						$("#callBackType").html("");
						var callBackTypeOptions = '<option value="">-- Select --</option>';
						if(callBackType == "TRUE") {
							if(callbackXml != null && callbackXml != "") {
								var callbackxmlDoc = $.parseXML(callbackXml),
							    $cbxml = $(callbackxmlDoc);
								$cbxml.find("ROW").each(function() {
									if($(this).find("DISPOSITIONCODE").text() == selecteddispCode) {
										$(this).find("CALLBACKTYPE").each(function() {
						    			    if($(this).find("SUBPROCESSID").text() != null && $(this).find("SUBPROCESSID").text() != "") {
						    			    	if($(this).find("SUBPROCESSID").text() == subProcessID) {
						    			    		if($(this).find("PERSONALFLAG").text() == 1) {
														callBackTypeOptions += '<option value="Personal">Personal</option>';
													}
													if($(this).find("CAMPAIGNFLAG").text() == 1) {
														callBackTypeOptions += '<option value="Campaign">Campaign</option>';
													}
						    			    	}
						    			    }
										});
									}
								});
							}
						}
						$("#callBackType").append(callBackTypeOptions);
						$("#callBackType option").each(function() {
							callbackTypeCount++;
				    	});
						if(callbackTypeCount > 1) {
							$("#callBackType").attr("disabled", false);
						} else {
							$("#callBackType").html("");
							$("#callBackType").attr("disabled", true);
						}
						
						var d1 = new Date();
					    var currDate = new Date(d1);
					    currDate.setHours(d1.getHours() + 24);
			            var date = currDate.getDate();
					    var month = currDate.getMonth() + 1; 
					    var year = currDate.getFullYear();
					    var hours = currDate.getHours();
					    var mins = currDate.getMinutes();
					    
						if(date < 10) {
						    date = '0' + date;
						} 
						if(month < 10) {
						    month = '0' + month;
						} 
						if(mins < 10) {
							mins = '0' + mins;
						} 
						
						var cbDateTime = year + "-" + month + "-" + date + " " + hours + ":" + mins;
						$("#callbackdatetimepicker").val(cbDateTime);
						
						$("#callbackdatetimepicker").attr("disabled", false);
						//$('#bottomdiv input[type="radio"]').each(function () { 
							// $(this).attr("disabled", false);
						//});
					} else {
						$("#callBackNumber").val("");
						$('#bottomdiv input[type="radio"]').each(function () { 
							 $(this).attr("checked", false);
						});
						$("#callBackNumber").removeClass("errorborder");
						$("#subDisposition").removeClass("errorborder");
						$("#callBackType").removeClass("errorborder");
						$("#callbackdatetimepicker").removeClass("errorborder");
						$("#callbackdatetimepicker").val("");
						$("#callBackNumber").attr("disabled", true);
						if(subdispoptioncount > 1) {
							$("#subDisposition").attr("disabled", false);
				    	} else {
				    		$("#subDisposition").html("");
				    		$("#subDisposition").attr("disabled", true);
				    	}
						$("#callBackType").attr("disabled", true);
						$("#callbackdatetimepicker").attr("disabled", true);
						//$('#bottomdiv input[type="radio"]').each(function () { $(this).attr("disabled", true);});
					}
				} else {
					$("#agentRemarks").val("");
					$("#callBackNumber").val("");
					$("#callBackNumber").attr("disabled", true);
					$("#callbackdatetimepicker").val("");
					$("#callbackdatetimepicker").attr("disabled", false);
					//$('#bottomdiv input[type="radio"]').each(function () { $(this).attr("disabled", true);});
				}
			});
			
	
	
			
			
			
			$(document).on('click', '#lobInfo', function () {
					$("#customerTable").hide();
					$("#processTable").show();
					$("#agentscriptslinks").hide();
					$("#historysearch").hide();
					$("#historydata").hide(); 
					
					$("#customerInfo").css("background-color", "#6f76cf");
					$("#lobInfo").css("background-color", "#3f3f3f");
					$("#callHistoryInfo").css("background-color", "#6f76cf");
					$("#agentScripts").css("background-color", "#6f76cf");
					$("#bottomdiv").show();
					
					// Added on 24-03-2017 LCS
					$("#lcstabdata").hide();
					$("#agentstatsinfo").show();
					$("#lcstab").css("background-color", "#6f76cf");
				
		    });
			
			$(document).on('click', '#callHistoryInfo', function () {
				$("#customerTable").hide();
				$("#processTable").hide();
				$("#agentscriptslinks").hide();
				$("#historysearch").show();
				$("#historydata").show();
				 
				var trailingCharsIntactCount = 4;
				var str =dail_no;
				//$("#phonenumber").val(dialNumber.replace(/\w(?=\w{4})/g, "X"));
				str = 'X'.repeat(str.length - trailingCharsIntactCount) + str.slice(-trailingCharsIntactCount);
				document.getElementById("phonenumber").value=str;
				$("#customerInfo").css("background-color", "#6f76cf");
				$("#lobInfo").css("background-color", "#6f76cf");
				$("#callHistoryInfo").css("background-color", "#3f3f3f");
				$("#agentScripts").css("background-color", "#6f76cf");
				$("#bottomdiv").hide();
				
				// Added on 24-03-2017 LCS
				$("#lcstabdata").hide();
				$("#agentstatsinfo").show();
				$("#lcstab").css("background-color", "#6f76cf");
		    });
			
			$("#buttonhistorysearch").click(function() {
				
				var historyData = "";
				var processID = 0;
				$("#historyshowdata").html("");
				 
				var AgentName=document.getElementById("agentNamedata").value;
				var number= document.getElementById("number_data").value; 
				 
				//AgentName = btoa(AgentName);
				//number = btoa(number);
				
				//  AgentName = CryptoJS.AES.encrypt(AgentName, secret);
				//  AgentName = AgentName.toString();
				  
				  //number = CryptoJS.AES.encrypt(number, secret);
				 // number = number.toString();
				  
				  processID = $("#lobInfo").attr("data");
				var phoneNO = $("#phonenumber").val();
				var subProcessName1=document.getElementById("subprocess_data").value;
				
				historyData += '<table id="tablehistory" style="width:100%">' +
				'<tr><th style="width : 130px;">Agent</th><th style="width : 200px;">Sub Process</th><th style="width : 130px;">Disposition</th><th style="width : 200px;">Sub Disposition</th><th style="width : 140px;">Date/Time</th><th style="width : 140px;">Remarks</th></tr>';
				
				if(phoneNO.indexOf("XXXX") == -1) {
					phoneNO = $("#phonenumber").val();
				} else {
					phoneNO = dialNumber;
				}
				/* if(phoneNO == null || phoneNO.length < 10 ) {
					$("#phonenumber").css("border", "1px solid red");
					$("#phonenumber").val("");
				} else {
					 
					if(phoneNO.indexOf("XXXX") == -1) {
						phoneNO = $("#phonenumber").val();
					} else {
						phoneNO = dialNumber;
					}
					  data: "opcode=Allcallhistory&phoneNo=" + phoneNO + "&processID=" + processID,  
				
					*/
					$("#phonenumber").css("border", "");
					  $.ajax({
				        type: "POST",
				        url: "portal",
				    	data: "opcode=callhistory&phoneNo=" + dail_no + "&subProcessName1=" + subProcessName1,
				        dataType: 'json',
				        success: function(response){
				        	var obj = JSON.parse(JSON.stringify(response));
				        //	console.log("==================callhistory============="+obj);
				        	var historyDetails = obj["historyDetails"];
				        	if(historyDetails != null) {
				        		for (var i = 0; i < historyDetails.length; i++) {
					        		historyData += '<tr style="height: 25px;"><td>' + (historyDetails[i]["agentName"] != "" && historyDetails[i]["agentName"] != null ? historyDetails[i]["agentName"] : "") + '</td>' + 
					        		
					        		'<td>' + (historyDetails[i]["subProcess"] != "" && historyDetails[i]["subProcess"] != null ? historyDetails[i]["subProcess"] : "") + '</td>' +
					        		'<td>' + (historyDetails[i]["dispostion"] != "" && historyDetails[i]["dispostion"] != null ? historyDetails[i]["dispostion"] : "") + '</td>' + 
					        		'<td>' + (historyDetails[i]["subDisposition"] != "" && historyDetails[i]["subDisposition"] != null ? historyDetails[i]["subDisposition"] : "") + '</td>' +
					        		'<td>' + (historyDetails[i]["dateTime"] != "" && historyDetails[i]["dateTime"] != null ? historyDetails[i]["dateTime"] : "") + '</td>' +
					        		'<td>' + (historyDetails[i]["remarks"] != "" && historyDetails[i]["remarks"] != null ? historyDetails[i]["remarks"] : "") + '</td>' +
					        		'</tr>';
								}
				        	} 
				        //	console.log("==================callhistory table============="+historyData);
				        	$("#historyshowdata").append(historyData);
				        	$("#historyshowdata").show();
				        },
				        error: function(e){
				        }
					});
				
			});
			
			$(document).on('click', '#agentScripts', function () {
				
				$("#agentscriptslinks").html("");
				$("#customerTable").hide();
				$("#processTable").hide();
				$("#historysearch").hide();
				$("#historydata").hide();
				$("#agentscriptslinks").hide();
				// Added on 24-03-2017 LCS
				$("#lcstabdata").hide();
				$("#agentstatsinfo").show();
				
				var scriptObject = [];
				var scriptlinks = "";
				var defaultscriptlink = "";
				if(AgentScriptDetails != null && AgentScriptDetails != "" && typeof AgentScriptDetails !== "undefined" ) {
					var scriptsLength = AgentScriptDetails.length;
					for(var i = 0; i < scriptsLength; i++) {
						scriptObject.push(AgentScriptDetails[i]);
					} 
					
					var scriptlength = scriptObject.length;
					for(var k = 0; k < scriptlength; k++) {
						if(AgentScriptDetails[k]["scriptDefault"] == 1) {
							defaultscriptlink += '<a href="#" class="scriptlinks" data="' + AgentScriptDetails[k]["scriptName"] +'">' + AgentScriptDetails[k]["scriptName"] + '</a>' + ((scriptlength > 1) ? '<br><br>' : '');
						} 
						if(AgentScriptDetails[k]["scriptDefault"] == 0) {
							scriptlinks += '<a href="#" class="scriptlinks" data="' + AgentScriptDetails[k]["scriptName"] +'">' + AgentScriptDetails[k]["scriptName"] +'</a>';
							if(AgentScriptDetails[k+1] != null) {
								scriptlinks += '<br><br>';
							} 
						}
					}
					$("#agentscriptslinks").append(defaultscriptlink + scriptlinks);
					$("#agentscriptslinks").show();
				}
				
				$("#customerInfo").css("background-color", "#6f76cf");
				$("#lobInfo").css("background-color", "#6f76cf");
				$("#agentScripts").css("background-color", "#3f3f3f");
				$("#callHistoryInfo").css("background-color", "#6f76cf");
				$("#bottomdiv").hide();
				// Added on 24-03-2017 LCS
				$("#lcstab").css("background-color", "#6f76cf");
		    });
			
			$(document).on('click', '#agentscriptslinks a', function () {
				var subProcessID = 0;
				if(scriptWindow != "" && scriptWindow != null && typeof scriptWindow !== "undefined" && !scriptWindow.closed) {
					scriptWindow.close();
				}
				if(subProcessDetails != null && subProcessDetails != "" &&  typeof subProcessDetails !== "undefined") {
					subProcessID = $("#subProcess").attr("data");
				}
				var fileName = $(this).attr("data");
			    $.ajax({
			        type: "POST",
			        url: "portal",
			        data: "opcode=scripts&subProcessID=" + subProcessID + "&fileName=" + fileName,
			        cache: false,
			        success: function(response){
			        	if(response == "") {
			        		response = '<body style="background: #ffffcc"><h1 style="color: red; text-align:center;">No script available</h1></body>';
			        	}
			        	var url = "agentScripting.jsp";
			        	var width = 1000;
					    var height = 500;
					    var left = parseInt((screen.availWidth/2) - (width/2));
					    var top = parseInt((screen.availHeight/2) - (height/2));
					    var windowFeatures = "width=" + width + ",height=" + height + ",scrollbars,left=" + left + ",top=" + top + "screenX=" + left + ",screenY=" + top;
					    scriptWindow = window.open("", "AgentScripting", windowFeatures);
					    scriptWindow.document.write(response);
					    scriptWindow.document.title="AgentScripting";
			        },
			        error: function(e){
				   }
	        	});
		    });
			
			$(document).on('click', "input[id$='_datetimepicker']", function () {
				var minDate = $(this).val();
				$(this).datetimepicker({
					 minDate: minDate,
					 step: 15,
					 format:'Y-m-d H:i'
					 /* onSelect: function(date) {
						 $(this).val("");
					} */
				});
			});
			
			$(document).on('click', "input[id$='_pdatetimepicker']", function () {
				var maxDate = $(this).val();
				 $(this).datetimepicker({
					 maxDate: maxDate,
					 step: 15,
					 format:'Y-m-d H:i'
				 });
			});
			$(document).on('click', "input[id$='_fdatetimepicker']", function () {
				var minDate = $(this).val();
				 $(this).datetimepicker({
					 minDate: minDate,
					 step: 15,
					 format:'Y-m-d H:i'
				 });
			});
			$(document).on('click', "input[id$='_pdatepicker']", function () {
				var maxDate = $(this).val();
				 $(this).datetimepicker({
					 maxDate: maxDate,
					 step: 15,
					 format:'Y-m-d',
					 timepicker:false
				 });
			});
			$(document).on('click', "input[id$='_fdatepicker']", function () {
				var minDate = $(this).val();
				 $(this).datetimepicker({
					 minDate: minDate,
					 step: 15,
					 format:'Y-m-d',
					 timepicker:false
				 });
			});
			
			// Added on 24-03-2017 LCS
			$(document).on('click', '#lcstab', function () {
				$("#lcstab").css("background-color", "#3f3f3f");
				$("#customerInfo").css("background-color", "#6f76cf");
				$("#lobInfo").css("background-color", "#6f76cf");
				$("#callHistoryInfo").css("background-color", "#6f76cf");
				$("#agentScripts").css("background-color", "#6f76cf");
				
				$("#lcstabdata").show();
				$("#customerTable").hide();
				$("#processTable").hide();
				$("#historysearch").hide();
				$("#historydata").hide();
				$("#agentscriptslinks").hide();
				$("#bottomdiv").hide();
				$("#agentstatsinfo").hide();
			});
			//Ended
			
		});
		
		function displayCustomerDetails(CustomerDetails) {
			
			
			 $("#navigationtabs").show();
				$("#navigationtabs").html("");
	            var navtabs = '<ul id="navigation" class="navigation">' +
			    '<li><span id="customerInfo">Customer Information</span></li>' +
			    '<li><span id="lobInfo" data="' + processDetails["PROCESSID"] + '" style="">' + processDetails["PROCESSNAME"] + '</span></li>' +
			    '<li><span id="callHistoryInfo">Call History</span></li>' +
			    '<li><span id="agentScripts">Agent Scripting</span></li>' +
			    '<label id="subProcess" data="' + subProcessDetails["SUBPROCESSID"] + '">' + subProcessDetails["SUBPROCESSNAME"] + '</label>' +
				'</ul>';
				$("#navigationtabs").append(navtabs);
				
			$("#customerTable").html("");
			$("#customerTable").show();
			$("#processTable").hide();
			$("#agentscriptslinks").hide();
			$("#historysearch").hide();
			$("#historydata").hide();
			// Added on 24-03-2017 LCS
			$("#lcstabdata").hide();
			$("#agentstatsinfo").show();
			// Ended
			$("#customerTable").append('<table style="width:100%"></table>');
			var table = $("#customerTable").children();
			//alert("Display Customer Details");
			document.getElementById("mobileNumber99").value=CustomerDetails["MOBILENUMBER1"];
			var customerDetails = "";
			customerDetails +=  '<tr>' +
		      '<td><label>Customer Name</label></td>' +
		      '<td><input type="text" id="customerName" name="customerName" readonly value="' + CustomerDetails["CUSTOMERNAME"] + '"></td>' +
		      '<td><label>Account Number</label></td>' +
		      '<td><input type="text" id="custAccountNumber" name="custAccountNumber" readonly value="' + CustomerDetails["ACCNUMBER"] + '"></td>' +
		    '</tr>' + 
		    '<tr>' +
		       '<td><label>Account Address</label></td>' +
		       '<td><textarea id="accountAddress" name="accountAddress"  rows="4" cols="25" readonly>' + CustomerDetails["ACCADDRESS"] + '</textarea></td>' +
		       '<td><label>Address</label></td>' +
		       '<td><textarea id="address" name="address" rows="4" cols="25" readonly>' + CustomerDetails["ADDRESS"] + '</textarea></td>' +
		     '</tr>' +
		     '<tr>' +
		       '<td><label>City</label></td>' +
		       '<td><input type="text" id="city" name="city" readonly value="' + CustomerDetails["CITY"] + '"></td>' +
		       '<td><label>Pin Code</label></td>' +
		       '<td><input type="text" id="pincode" name="pincode" readonly value="' + CustomerDetails["PINCODE"] + '"></td>' +
		     '</tr>' +
		     '<tr>' +
		       '<td><label>Eligible Card</label></td>' +
		       '<td><input type="text" id="eligibleCard" name="eligibleCard" readonly value="' + CustomerDetails["ELIGIBLECARD"] + '"></td>' +
		       '<td><label>Promo Code</label></td>' +
		       '<td><input type="text" id="promoCode" name="promoCode" readonly value="' + CustomerDetails["PROMOCODE"] + '"></td>' +
		     '</tr>' +
		     '<tr>' +
		       '<td><label>CIF Number</label></td>' +
		       '<td><input type="text" id="cifNumber" name="cifNumber" readonly value="' + CustomerDetails["CIFNUMBER"] + '"></td>' +
		       '<td><label>PAN Number</label></td>' +
		       '<td><input type="text" id="panNumber" name="panNumber" readonly value="' + CustomerDetails["PANNUMBER"] + '"></td>' +
		     '</tr>' +
		     '<tr>' +
		       '<td><label>DOB</label></td>' +
		       '<td><input type="text" id="dob" name="DOB" value="' + CustomerDetails["DOB"] + '"></td>' +
		       '<td><label>Gender</label></td>' +
		       '<td><input type="text" id="gender" name="gender" readonly value="' + CustomerDetails["GENDER"] + '"></td>' +
		     '</tr>' +
			   '<tr>' +
			   '<td><label>Occupation</label></td>' +
		       '<td><input type="text" id="occupation" name="occupation" readonly value="' + CustomerDetails["OCCUPATION"] + '"></td>' +
		       '<td><label>Mobile Number</label></td>' +
		       '<td><input type="text" id="mobileNumber" name="mobileNumber" readonly value="' + CustomerDetails["MOBILENUMBER"] + '"></td>' + 
		      
		     '</tr>' +
		     '<tr>' +
		       '<td><label>Alternate Number1</label></td>' +
		       '<td><input type="text" id="altNum1" name="altNum1" readonly value="' + CustomerDetails["ALTERNATENUMBER1"] + '"></td>' +
		       '<td><label>Alternate Number2</label></td>' +
		       '<td><input type="text" id="altNum2" name="altNum2" readonly value="' + CustomerDetails["ALTERNATENUMBER2"] + '"></td>' +
		     '</tr>' +
		     '<tr>' +
		       '<td><label>Tentative Card Limit</label></td>' +
		       '<td><input type="text" id="tentativeCardLimit" name="tentativeCardLimit" readonly value="' + CustomerDetails["TENTATIVECARDLIMIT"] + '"></td>' +
		       '<td><label>Unique Key</label></td>' +
		       '<td><input type="text" id="uniqueKey" name="uniqueKey" readonly value="' + CustomerDetails["UNIQUEKEY"] + '"></td>' +
		     '</tr>' +
		     '<tr>' +
		       '<td><label>Email ID</label></td>' +
		       '<td><input type="text" id="emailID" name="emailID" readonly value="' + CustomerDetails["EMAILID"] + '"></td>' +
		       '<td><label>Loan Type</label></td>' +
		       '<td><input type="text" id="loanType" name="loanType" readonly value="' + CustomerDetails["LOANTYPE"] + '"></td>' +
		     '</tr>' +
		     '<tr>' +
		       '<td><label>Branch Name</label></td>' +
		       '<td><input type="text" id="branchName" name="branchName" readonly value="' + CustomerDetails["BRANCHNAME"] + '"></td>' +
		       '<td><label>Branch Code</label></td>' +
		       '<td><input type="text" id="branchCode" name="branchCode" readonly value="' + CustomerDetails["BRANCHCODE"] + '"></td>' +
		     '</tr>' +
		     '<tr>' +
		       '<td><label>Circle</label></td>' +
		       '<td><input type="text" id="circle" name="circle" readonly value="' + CustomerDetails["CIRCLE"] + '"></td>' +
		       '<td><label>I-RAC</label></td>' +
		       '<td><input type="text" id="i-rac" name="i-rac" readonly value="' + CustomerDetails["IRAC"] + '"></td>' +
		     '</tr>' +
		     '<tr>' +
		       '<td><label>Lead Number</label></td>' +
		       '<td><input type="text" id="leadNumber" name="leadNumber" readonly value="' + CustomerDetails["LEADNUMBER"] + '"></td>' +
		       '<td><label>Batch ID</label></td>' +
		       '<td><input type="text" id="batchID" name="batchID" readonly value="' + CustomerDetails["BATCHID"] + '"></td>' +
		     '</tr>' +
		     '<tr>' +
		       '<td><label>Data Type</label></td>' +
		       '<td><input type="text" id="dataType" name="dataType" readonly value="' + CustomerDetails["DATATYPE"] + '"></td>' +
		       '<td><label>Entry Date</label></td>' +
		       '<td><input type="text" id="entryDate" name="entryDate" readonly value="' + CustomerDetails["ENTRYDATE"] + '"></td>' +
		     '</tr>' +
		     '<tr>' +
		       '<td><label>Lead Reference Number</label></td>' +
		       '<td><input type="text" id="leadReferenceNumber" name="leadReferenceNumber" readonly value="' + CustomerDetails["LEADREFNUMBER"] + '"></td>' +
		       '<td><label>Surrogate Type</label></td>' +
		       '<td><input type="text" id="surrogateType" name="surrogateType" readonly value="' + CustomerDetails["SURROGATETYPE"] + '"></td>' +
		     '</tr>' +
		     '<tr>' +
		       '<td><label>Campaign</label></td>' +
		       '<td><input type="text" id="campaign" name="campaign" readonly value="' + CustomerDetails["CAMPAIGN"] + '"></td>' +
		       '<td><label>Product Name</label></td>' +
		       '<td><input type="text" id="productName" name="productName" readonly value="' + CustomerDetails["PRODUCTNAME"] + '"></td>' +
		     '</tr>' +
		     '<tr>' +
		       '<td><label>Source Code</label></td>' +
		       '<td><input type="text" id="sourceCode" name="sourceCode" readonly value="' + CustomerDetails["SOURCECODE"] + '"></td>' +
		       '<td><label>Age</label></td>' +
		       '<td><input type="text" id="age" name="age" readonly value="' + CustomerDetails["AGE"] + '"></td>' +
		     '</tr>' +
		     '<tr>' +
		       '<td><label>UCID</label></td>' +
		       '<td><input type="text" id="UCID" name="UCID" readonly value="' + CustomerDetails["UCID"] + '"></td>' +
		       '<td><label>CSAT_DATE</label></td>' +
		       '<td><input type="text" id="csatdate" name="csatdate" readonly value="' + CustomerDetails["CSATDATE"] + '"></td>' +
		     '</tr>';
			table.append(customerDetails);
		
			$("#customerInfo").css("background-color", "#3f3f3f");
			$("#lobInfo").css("background-color", "#696969");
			$("#callHistoryInfo").css("background-color", "#696969");
			$("#agentScripts").css("background-color", "#696969");
			$("#bottomdiv").show(); 
			// Added on 24-03-2017 LCS
			$("#lcstab").css("background-color", "#696969");
			
			

		}
		
		 
		
		function displayCustomerDetailsGenesys(objj) {
		 
			 $("#navigationtabs").show();
				$("#navigationtabs").html("");
	            var navtabs = '<ul id="navigation" class="navigation">' +
			    '<li><span id="customerInfo1">Customer Information</span></li>' +
			   
			    '<li><span id="callHistoryInfo">Call History</span></li>' +
			    '<label id="subProcess" data="' + SUBPROCESSID_mk + '"></label>' +
			    '<li><span id="agentScripts">Agent Scripting</span></li>' +
			   
				'</ul>';
				$("#navigationtabs").append(navtabs);
				
			$("#customerTable").html("");
			$("#customerTable").show();
			$("#processTable").hide();
			$("#agentscriptslinks").hide();
			$("#historysearch").hide();
			$("#historydata").hide();
			// Added on 24-03-2017 LCS
			$("#lcstabdata").hide();
			$("#agentstatsinfo").show();
			// Ended
			$("#customerTable").append('<table style="width:100%"></table>');
			var table = $("#customerTable").children();
			//alert("Display Customer Details");
			var maskedno = "XXXXXX"+objj.ContactInfo.substring(6);
			 var customerDetails="";
			customerDetails +=  '<tr>' +
		      '<td><label>Customer Name</label></td>' +
		      '<td><input type="text" id="Cutomer_Name" name="Cutomer_Name" readonly value="' + objj.cti_CUSTOMER_NAME + '"></td>' +
		      '<td><label>SR_NO</label></td>' +
		      '<td><input type="text" id="SR_NO88" name="SR_NO88" readonly value="' + objj.cti_Account_No + '"></td>' +
		    '</tr>' + 
		     
		     '<tr>' +
		       '<td><label>ELIGIBLE LOAN AMOUNT </label></td>' +
		       '<td><input type="text" id="ELIGIBLE_LOAN_AMOUNT88" name="ELIGIBLE_LOAN_AMOUNT88" readonly value="' + objj.cti_AMOUNT_OVERDUE + '"></td>' +
		       '<td><label>Circle</label></td>' +
		       '<td><input type="text" id="Circle88" name="Circle88" readonly value="' + objj.cti_CIRCLE_DESC + '"></td>' +
		     '</tr>' +
			  '<tr>' +
			   '<td><label>Product Type</label></td>' +
		       '<td><input type="text" id="Product_Type88" name="Product_Type88" readonly value="' + objj.cti_PRODUCT_TYPE + '"></td>' +
		       '<td><label>LEAD TYPE</label></td>' +
		       '<td><input type="text" id="LEAD_TYPE88" name="LEAD_TYPE88" readonly value="' + objj.cti_delinquency+ '"></td>' + 
		     '</tr>' +
			 
			 
		     '<tr>' +
		       '<td><label>BRANCH CODE</label></td>' +
		       '<td><input type="text" id="BRANCH_CODE88" name="BRANCH_CODE88" readonly value="' + objj.cti_CUST_ID + '"></td>' +
		       '<td><label>INB STATUS</label></td>' +
		       '<td><input type="text" id="INB_STATUS88" name="INB_STATUS88" readonly value="' + objj.cti_SMA_RG + '"></td>' +
		     '</tr>' +
		      
		     '<tr>' +
		       '<td><label>YONO STATUS</label></td>' +
		       '<td><input type="text" id="YONO_STATUS88" name="YONO_STATUS88" readonly value="' + objj.cti_P2P_Amount + '"></td>' +
		       '<td><label>GENDER</label></td>' +
		       '<td><input type="text" id="GENDER88" name="GENDER88" readonly value="' + objj.cti_GENDER + '"></td>' +
		     '</tr>' +
		     '<tr>' +
		       '<td><label>CUSTOMER AGE</label></td>' +
		       '<td><input type="text" id="CUSTOMER_AGE88" name="CUSTOMER_AGE88" readonly value="' + objj.cti_CUSTOMER_AGE + '"></td>' +
		       '<td><label>BRANCH NAME</label></td>' +
		       '<td><input type="text" id="BRANCH_NAME88" name="BRANCH_NAME88" readonly value="' + objj.cti_BRANCH_NAME + '"></td>' +
		     '</tr>' +
		     '<tr>' +
		       '<td><label>PROCESSING FEE</label></td>' +
		       '<td><input type="text" id="PROCESSING_FEE88" name="PROCESSING_FEE88" readonly value="' + objj.cti_PROCESSING_FEE + '"></td>' +
		       '<td><label> MAX_TENURE</label></td>' +
		       '<td><input type="text" id="MAX_TENURE88" name="MAX_TENURE88" readonly value="' + objj.cti_MAX_TENURE + '"></td>' +
		     '</tr>' +
		     '<tr>' +
		       '<td><label>LEAD AGEING</label></td>' +
		       '<td><input type="text" id="LEAD_AGEING88" name="LEAD_AGEING88" readonly value="' + objj.cti_LEAD_AGEING + '"></td>' +
		       '<td><label> NOT CONTACTED</label></td>' +
		       '<td><input type="text" id="NOT_CONTACTED88" name="NOT_CONTACTED88" readonly value="' + objj.cti_NOT_CONTACTED + '"></td>' +
		     '</tr>' +
		     '<tr>' +
		       '<td><label>BRANCH LAST STATUS IDENTIFIED</label></td>' +
		       '<td><input type="text" id="BRANCH_LAST_STATUS_IDENTIFIED88" name="BRANCH_LAST_STATUS_IDENTIFIED88" readonly value="' + objj.cti_BRANCH_LAST_STATUS_IDENTIFIED + '"></td>' +
		       '<td><label> Extra</label></td>' +
		       '<td><input type="text" id="cti_EXTRA88" name="cti_EXTRA88" readonly value="' + objj.cti_EXTRA + '"></td>' +
		     '</tr>' +
			 
		     '<tr>' +
		       '<td><label>ROI</label></td>' +
		       '<td><input type="text" id="ROI88" name="ROI88" readonly value="' + objj.cti_ROI + '"></td>' +
		       '<td><label>Mobile Number</label></td>' +
		       '<td><input type="text" id="Mobile_Number88" name="Mobile_Number88" readonly value="' + maskedno + '"></td>' +
		     '</tr>'  
			  
		         
			table.append(customerDetails);
		 
			$("#customerInfo").css("background-color", "#3f3f3f");
			$("#lobInfo").css("background-color", "#696969");
			$("#callHistoryInfo").css("background-color", "#696969");
			$("#agentScripts").css("background-color", "#696969");
			$("#bottomdiv").show(); 
			// Added on 24-03-2017 LCS
			$("#lcstab").css("background-color", "#696969");
			
			

		}
		
	
		 
		
		function displayLOBDetails(LOBDetails) {
			// Commented on 26-06-2017 for LOTUS
			//$("#processTable").hide();
			$("#processTable").html("");
			
			$("#processTable").append('<table style="width:100%;"></table>');
			var table = $("#processTable").children();    
		
			var lobDetails = "";
			var arrayKeys = [];
			for(var k in LOBDetails) {
				arrayKeys.push(k);
			} 
			var loblength = arrayKeys.length;
			
			var labelKeys = [];
			for(var k in labelMapDetails) {
				labelKeys.push(k);
			} 
			const myObj="";
			const myJSON="";
			var orderObject = [];
			for(var k = 0; k < orderMapDetails.length; k++) {
				orderObject.push(orderMapDetails[k]);
			} 
			
			var orderKeys = [];
			for(var k = 0; k < orderObject.length; k++) {
				orderKeys.push(orderMapDetails[k]["orderNo"]); 
			}
			
			var orderObjectLength = orderObject.length;
			if(orderObjectLength == 1) {
				for(var l = 0; l < orderObjectLength; l++) {
					lobDetails += '<tr>';
				for(var i = 0; i < loblength; i++) {
						for(var j = 0; j < labelKeys.length; j++) {
							if(arrayKeys[i] == labelMapDetails[labelKeys[j]] && orderMapDetails[l]["displayName"] == arrayKeys[i]) {
								lobDetails += '<tr>';
								if(orderMapDetails[l]["type"] == "PCALENDAR") {
									lobDetails += '<td style="width:25%;"><label id="' + labelKeys[j] + '">' + arrayKeys[i] + '</label>' + (orderMapDetails[l]["mandatory"] == "Y" ? "<span style='color:red;'>*</span>" : "") +  '</td>' +
								    '<td><input type="text" readonly id="' + LOBDetails[arrayKeys[i]] + '_pdatetimepicker" name="' + LOBDetails[arrayKeys[i]] + '" value="' + LOBDetails[arrayKeys[i]] + '"><img style="margin-top:5px;" src="images/png/20x20/Calendar.png" width="15" height="15"></td>';
								} else if(orderMapDetails[l]["type"] == "FCALENDAR") {
									lobDetails += '<td style="width:25%;"><label id="' + labelKeys[j] + '">' + arrayKeys[i] + '</label>' + (orderMapDetails[l]["mandatory"] == "Y" ? "<span style='color:red;'>*</span>" : "") +  '</td>' +
								    '<td><input type="text" readonly id="' + LOBDetails[arrayKeys[i]] + '_fdatetimepicker" name="' + LOBDetails[arrayKeys[i]] + '" value="' + LOBDetails[arrayKeys[i]] + '"><img style="margin-top:5px;" src="images/png/20x20/Calendar.png" width="15" height="15"></td>';
								} else if(orderMapDetails[l]["type"] == "PDATE") {
									lobDetails += '<td style="width:25%;"><label id="' + labelKeys[j] + '">' + arrayKeys[i] + '</label>' + (orderMapDetails[l]["mandatory"] == "Y" ? "<span style='color:red;'>*</span>" : "") +  '</td>' +
								    '<td><input type="text" readonly id="' + LOBDetails[arrayKeys[i]] + '_pdatepicker" name="' + LOBDetails[arrayKeys[i]] + '" value="' + LOBDetails[arrayKeys[i]] + '"><img style="margin-top:5px;" src="images/png/20x20/Calendar.png" width="15" height="15"></td>';
								} else if(orderMapDetails[l]["type"] == "FDATE") {
									lobDetails += '<td style="width:25%;"><label id="' + labelKeys[j] + '">' + arrayKeys[i] + '</label>' + (orderMapDetails[l]["mandatory"] == "Y" ? "<span style='color:red;'>*</span>" : "") +  '</td>' +
								    '<td><input type="text" readonly id="' + LOBDetails[arrayKeys[i]] + '_fdatepicker" name="' + LOBDetails[arrayKeys[i]] + '" value="' + LOBDetails[arrayKeys[i]] + '"><img style="margin-top:5px;" src="images/png/20x20/Calendar.png" width="15" height="15"></td>';
								} else if(orderMapDetails[l]["type"] == "textbox") {
									lobDetails += '<td style="width:25%;"><label id="' + labelKeys[j] + '">' + arrayKeys[i] + '</label>' + (orderMapDetails[l]["mandatory"] == "Y" ? "<span style='color:red;'>*</span>" : "") +  '</td>' +
								    '<td><input type="text" id="' + LOBDetails[arrayKeys[i]] + '" class="numbercheck" data="' + orderMapDetails[l]["dataType"] + '" name="' + LOBDetails[arrayKeys[i]] + '" value="' + LOBDetails[arrayKeys[i]] + '"></td>';
								} else if(orderMapDetails[l]["type"] == "textarea") {
									lobDetails += '<td style="width:25%;"><label id="' + labelKeys[j] + '">' + arrayKeys[i] + '</label>' + (orderMapDetails[l]["mandatory"] == "Y" ? "<span style='color:red;'>*</span>" : "") +  '</td>' +
									'<td><textarea id="' + LOBDetails[arrayKeys[i]] + '" maxlength="' + orderMapDetails[l]["size"] + '" class="numbercheck" data="' + orderMapDetails[l]["dataType"] + '" rows="4" cols="25">' + LOBDetails[arrayKeys[i]] + '</textarea></td>';
								} else if(orderMapDetails[l]["type"] == "select") {
									lobDetails += '<td style="width:25%;"><label id="' + labelKeys[j] + '">' + arrayKeys[i] + '</label>' + (orderMapDetails[l]["mandatory"] == "Y" ? "<span style='color:red;'>*</span>" : "") +  '</td>' +
									'<td><select id="' + LOBDetails[arrayKeys[i]] + '"><option value="">-- Select --</option>';
									var splitArray = orderMapDetails[l]["values"].split(",")
									for(var m =0; m < splitArray.length; m++) {
										lobDetails += '<option value="' + splitArray[m] + '"' + (LOBDetails[arrayKeys[i]] == splitArray[m] ? selected="selected" : "") + ' title="' + splitArray[m] + '">' + splitArray[m] + '</option>';
									}
									lobDetails += '<select></td>';
								}
								lobDetails += '</tr>';
							}
						}
					}
					lobDetails += '</tr>';   
				}
			} else {
				for(var l = 0; l < orderObject.length; l++) {
					for(var i = 0; i < loblength; i++) {
						for(var j = 0; j < labelKeys.length; j++) {
							if(arrayKeys[i] == labelMapDetails[labelKeys[j]] && orderMapDetails[l]["displayName"] == arrayKeys[i]) {
								if(orderMapDetails[l]["orderNo"]  % 2 == 1) {
									lobDetails += '<tr>';
									if(orderMapDetails[l]["type"] == "PCALENDAR") {
										lobDetails += '<td><label id="' + labelKeys[j] + '">' + arrayKeys[i] + '</label>' + (orderMapDetails[l]["mandatory"] == "Y" ? "<span style='color:red;'>*</span>" : "") +  '</td>' +
									    '<td><input type="text" readonly id="' + LOBDetails[arrayKeys[i]] + '_pdatetimepicker" name="' + LOBDetails[arrayKeys[i]] + '" value="' + LOBDetails[arrayKeys[i]] + '"><img style="margin-top:5px;" src="images/png/20x20/Calendar.png" width="15" height="15"></td>';
									} else if(orderMapDetails[l]["type"] == "FCALENDAR") {
										lobDetails += '<td><label id="' + labelKeys[j] + '">' + arrayKeys[i] + '</label>' + (orderMapDetails[l]["mandatory"] == "Y" ? "<span style='color:red;'>*</span>" : "") +  '</td>' +
									    '<td><input type="text" readonly id="' + LOBDetails[arrayKeys[i]] + '_fdatetimepicker" name="' + LOBDetails[arrayKeys[i]] + '" value="' + LOBDetails[arrayKeys[i]] + '"><img style="margin-top:5px;" src="images/png/20x20/Calendar.png" width="15" height="15"></td>';
									} else if(orderMapDetails[l]["type"] == "PDATE") {
										lobDetails += '<td><label id="' + labelKeys[j] + '">' + arrayKeys[i] + '</label>' + (orderMapDetails[l]["mandatory"] == "Y" ? "<span style='color:red;'>*</span>" : "") +  '</td>' +
									    '<td><input type="text" readonly id="' + LOBDetails[arrayKeys[i]] + '_pdatepicker" name="' + LOBDetails[arrayKeys[i]] + '" value="' + LOBDetails[arrayKeys[i]] + '"><img style="margin-top:5px;" src="images/png/20x20/Calendar.png" width="15" height="15"></td>';
									} else if(orderMapDetails[l]["type"] == "FDATE") {
										lobDetails += '<td><label id="' + labelKeys[j] + '">' + arrayKeys[i] + '</label>' + (orderMapDetails[l]["mandatory"] == "Y" ? "<span style='color:red;'>*</span>" : "") +  '</td>' +
									    '<td><input type="text" readonly id="' + LOBDetails[arrayKeys[i]] + '_fdatepicker" name="' + LOBDetails[arrayKeys[i]] + '" value="' + LOBDetails[arrayKeys[i]] + '"><img style="margin-top:5px;" src="images/png/20x20/Calendar.png" width="15" height="15"></td>';
									} else if(orderMapDetails[l]["type"] == "textbox") {
										lobDetails += '<td><label id="' + labelKeys[j] + '">' + arrayKeys[i] + '</label>' + (orderMapDetails[l]["mandatory"] == "Y" ? "<span style='color:red;'>*</span>" : "") +  '</td>' +
									    '<td><input type="text" id="' + LOBDetails[arrayKeys[i]] + '" class="numbercheck" data="' + orderMapDetails[l]["dataType"] + '"  name="' + LOBDetails[arrayKeys[i]] + '" value="' + LOBDetails[arrayKeys[i]] + '"></td>';
									} else if(orderMapDetails[l]["type"] == "textarea") {
										lobDetails += '<td><label id="' + labelKeys[j] + '">' + arrayKeys[i] + '</label>' + (orderMapDetails[l]["mandatory"] == "Y" ? "<span style='color:red;'>*</span>" : "") +  '</td>' +
										'<td><textarea id="' + LOBDetails[arrayKeys[i]] + '" maxlength="' + orderMapDetails[l]["size"] + '"  class="numbercheck" data="' + orderMapDetails[l]["dataType"] + '"  rows="4" cols="25">' + LOBDetails[arrayKeys[i]] + '</textarea></td>';
									} else if(orderMapDetails[l]["type"] == "select") {
										lobDetails += '<td><label id="' + labelKeys[j] + '">' + arrayKeys[i] + '</label>' + (orderMapDetails[l]["mandatory"] == "Y" ? "<span style='color:red;'>*</span>" : "") +  '</td>' +
										'<td><select id="' + LOBDetails[arrayKeys[i]] + '"><option value="">-- Select --</option>';
										var splitArray = orderMapDetails[l]["values"].split(",")
										for(var m =0; m < splitArray.length; m++) {
											lobDetails += '<option value="' + splitArray[m] + '"' + (LOBDetails[arrayKeys[i]] == splitArray[m] ? selected="selected" : "") + ' title="' + splitArray[m] + '">' + splitArray[m] + '</option>';
										}
										lobDetails += '<select></td>';
									}
								} else  {
									if(orderMapDetails[l]["type"] == "PCALENDAR") {
										lobDetails += '<td><label id="' + labelKeys[j] + '">' + arrayKeys[i] + '</label>' + (orderMapDetails[l]["mandatory"] == "Y" ? "<span style='color:red;'>*</span>" : "") +  '</td>' +
									    '<td><input type="text" readonly id="' + LOBDetails[arrayKeys[i]] + '_pdatetimepicker" name="' + LOBDetails[arrayKeys[i]] + '" value="' + LOBDetails[arrayKeys[i]] + '"><img style="margin-top:5px;" src="images/png/20x20/Calendar.png" width="15" height="15"></td>';
									} else if(orderMapDetails[l]["type"] == "FCALENDAR") {
										lobDetails += '<td><label id="' + labelKeys[j] + '">' + arrayKeys[i] + '</label>' + (orderMapDetails[l]["mandatory"] == "Y" ? "<span style='color:red;'>*</span>" : "") +  '</td>' +
									    '<td><input type="text" readonly id="' + LOBDetails[arrayKeys[i]] + '_fdatetimepicker" name="' + LOBDetails[arrayKeys[i]] + '" value="' + LOBDetails[arrayKeys[i]] + '"><img style="margin-top:5px;" src="images/png/20x20/Calendar.png" width="15" height="15"></td>';
									} else if(orderMapDetails[l]["type"] == "PDATE") {
										lobDetails += '<td><label id="' + labelKeys[j] + '">' + arrayKeys[i] + '</label>' + (orderMapDetails[l]["mandatory"] == "Y" ? "<span style='color:red;'>*</span>" : "") +  '</td>' +
									    '<td><input type="text" readonly id="' + LOBDetails[arrayKeys[i]] + '_pdatepicker" name="' + LOBDetails[arrayKeys[i]] + '" value="' + LOBDetails[arrayKeys[i]] + '"><img style="margin-top:5px;" src="images/png/20x20/Calendar.png" width="15" height="15"></td>';
									} else if(orderMapDetails[l]["type"] == "FDATE") {
										lobDetails += '<td><label id="' + labelKeys[j] + '">' + arrayKeys[i] + '</label>' + (orderMapDetails[l]["mandatory"] == "Y" ? "<span style='color:red;'>*</span>" : "") +  '</td>' +
									    '<td><input type="text" readonly id="' + LOBDetails[arrayKeys[i]] + '_fdatepicker" name="' + LOBDetails[arrayKeys[i]] + '" value="' + LOBDetails[arrayKeys[i]] + '"><img style="margin-top:5px;" src="images/png/20x20/Calendar.png" width="15" height="15"></td>';
									} else if(orderMapDetails[l]["type"] == "textbox") {
										lobDetails += '<td><label id="' + labelKeys[j] + '">' + arrayKeys[i] + '</label>' + (orderMapDetails[l]["mandatory"] == "Y" ? "<span style='color:red;'>*</span>" : "") +  '</td>' +
									    '<td><input type="text" id="' + LOBDetails[arrayKeys[i]] + '" class="numbercheck" data="' + orderMapDetails[l]["dataType"] + '" name="' + LOBDetails[arrayKeys[i]] + '" value="' + LOBDetails[arrayKeys[i]] + '"></td>';
									} else if(orderMapDetails[l]["type"] == "textarea") {
										lobDetails += '<td><label id="' + labelKeys[j] + '">' + arrayKeys[i] + '</label>' + (orderMapDetails[l]["mandatory"] == "Y" ? "<span style='color:red;'>*</span>" : "") +  '</td>' +
										'<td><textarea id="' + LOBDetails[arrayKeys[i]] + '" maxlength="' + orderMapDetails[l]["size"] + '"  class="numbercheck" data="' + orderMapDetails[l]["dataType"] + '" rows="4" cols="25">' + LOBDetails[arrayKeys[i]] + '</textarea></td>';
									} else if(orderMapDetails[l]["type"] == "select") {
										lobDetails += '<td><label id="' + labelKeys[j] + '">' + arrayKeys[i] + '</label>' + (orderMapDetails[l]["mandatory"] == "Y" ? "<span style='color:red;'>*</span>" : "") +  '</td>' +
										'<td><select id="' + LOBDetails[arrayKeys[i]] + '"><option value="">-- Select --</option>';
										var splitArray = orderMapDetails[l]["values"].split(",")
										for(var m =0; m < splitArray.length; m++) {
											lobDetails += '<option value="' + splitArray[m] + '"' + (LOBDetails[arrayKeys[i]] == splitArray[m] ? selected="selected" : "") + ' title="' + splitArray[m] + '">' + splitArray[m] + '</option>';
										}
										lobDetails += '<select></td>'; 
									}
									lobDetails += '</tr>';
								}
							}	
						}
					}
				}
			}

			table.append(lobDetails);
			
		}
		
		 
			var myVar = null; 
			var switchsession = null;
			var updateData=true;
			var lastupdate='';
			var notreadyaux=false;
			var timer25min;
			var updateData=true;
			var dialenabled=false;
			//var tt=true;
			 
		$(document).ready(function(){
			
			$(".only-numeric").bind("keypress", function (e) {
		        var keyCode = e.which ? e.which : e.keyCode
		             
		        if (!(keyCode >= 48 && keyCode <= 57)) {
		          
		          return false;
		        }else{
		          $(".only-numeric").css("display", "inline");
					
		        }
		    });
			
			var d1 = new Date();
			   var currDate = new Date(d1);
			   currDate.setHours(d1.getHours() + 24);
			         var date = currDate.getDate();
			   var month = currDate.getMonth() + 1; 
			   var year = currDate.getFullYear();
			   var hours = currDate.getHours();
			   var mins = currDate.getMinutes()+10;
			   
			if(date < 10) {
			    date = '0' + date;
			} 
			if(month < 10) {
			    month = '0' + month;
			} 
			if(mins < 10) {
				mins = '0' + mins;
			} 
			
			var cbDateTime = year + "-" + month + "-" + date + " " + hours + ":" + mins;
			 var date1 = currDate.getDate()+7;
			var maxdate = year + "-" + month + "-" + date1 + " " + hours + ":" + mins;
			//alert(maxdate);
			
			$("#callbackdatetimepicker").val(cbDateTime);
			
			$("#callbackdatetimepicker").click(function(){
					
					 
					 $("#callbackdatetimepicker").datetimepicker({
						 minDate: 0,
						 step: 05,
						 format: 'Y-m-d hh:mm'
						  
						 
					 });
				});
			
			$('#disposition').on('change', function() {
				  
				  if(this.value == 'Call Back' ){
					$('#callbackdatetimepicker').prop("disabled", false);
					$('#callBackNumber').prop("disabled", false); // manjit
					document.getElementById("snz1").disabled = false; //manjit
					document.getElementById("snz2").disabled = false; //manjit
					document.getElementById("snz3").disabled = false; //manjit
					document.getElementById("snz4").disabled = false; //manjit
					document.getElementById("snz").disabled = false; //manjit
				 
				  }else{
					  
						
					  $('#callbackdatetimepicker').prop("disabled", true);
						$('#cbtype').prop("disabled", true);
						
						$('#callBackNumber').prop("disabled", true); // manjit
						document.getElementById("snz1").disabled = true; //manjit
						document.getElementById("snz2").disabled = true; //manjit
						document.getElementById("snz3").disabled = true; //manjit
						document.getElementById("snz4").disabled = true; //manjit
						document.getElementById("snz").disabled = true; //manjit
					//	document.getElementByName("snooze1").disabled = false; //manjit
					 
				  }
				  
				  if( this.value == 'Language Barrier'){
						$("#language").prop("disabled", false);
						
					  }else{
						  document.getElementById("language").value="";
							$("#language").prop("disabled", true);
					 
					  }
					  
				  
				  
				});
			
			$("#login").click(function(){
				
				 username = $("#email").val();
				var password = $("#password").val();
				 place=$("#place").val();
				$('#login').prop("disabled", false);
				// Checking for blank fields.
				if( username =='' || password =='' || place==''){
					$('input[type="text"],input[type="password"]').css("border","2px solid red");
					$('input[type="text"],input[type="password"]').css("box-shadow","0 0 3px red");
					//alert("Please fill all fields...!!!!!!");
				}else {
					$('#login').prop("disabled", true);
				 
					var Agent_username = CryptoJS.AES.encrypt(username, secret);
					Agent_username = Agent_username.toString();
					var Agent_pwd = CryptoJS.AES.encrypt(password, secret);
					Agent_pwd = Agent_pwd.toString();
					//$.post(main_url+"Login",{ username1: Agent_username, password1:Agent_pwd, place1:place},
					$.post(main_url+"Login",{ username1: Agent_username, password1:Agent_pwd, place1:place},	
							function(data) {
								 myJSON = data;
								 myObj = JSON.parse(myJSON);
						var boolValue = JSON.parse(data);
						  
						if(myObj.out){
							check_ready= true;
							document.getElementById("agentNamedata").value=username;
							document.getElementById("agentNamedata1").innerHTML=username;
							
							 $("form")[0].reset();
								$('input[type="text"],input[type="password"]').css({"border":"2px solid #00F5FF","box-shadow":"0 0 5px #00F5FF"});
								$("#divlogoDisplay").hide();
								  $("#divappletlogin").hide();
								  $("#divappletbody").show();
								  $("#divheadertable").show();
								  apidata=true;
								  sessiondata=myObj.WWESession;
								    authdata= myObj.auth;
								 switchsession = setInterval(myTimer, 5000);
							  	 StatusFunc('NotReadyDuration','Red');
							  	getKVPairList1(true);
							  	 GetAgentCallBackCount();
								 getAgentStatusdata();
								var first_timer=true;
						 
							   interval = setInterval(function() {
								if(first_timer)   {
									myTimer();
									first_timer=false;
								
								}
								getStaticsData();
								
								 }, 40000);
							   
							   
				 
						}else{
							alert(myObj.USERDATA);
							$('#login').prop("disabled", false);
							$('input[type="text"]').css({"border":"2px solid red","box-shadow":"0 0 3px red"});
							$('input[type="password"]').css({"border":"2px solid red","box-shadow":"0 0 3px red"});
							
						}
						
					});
					
				$.post("Login",{ username1: Agent_username, password1:Agent_pwd, place1:place},
					    // $.post("Login",{ username1: username, password1:password, place1:place},							
									function(data) {
										  	
								//var Bankdata = JSON.parse(data);
								
							 ssokey=data;
							 console.log("========="+ssokey.length);
							 if(ssokey == null || ssokey == '' ){
								 deleteAllCookies();
								  window.location.reload(true);
							 
								 $('#login').prop("disabled", false);
									$('input[type="text"]').css({"border":"2px solid red","box-shadow":"0 0 3px red"});
									$('input[type="password"]').css({"border":"2px solid red","box-shadow":"0 0 3px red"});   
							 }else{
								 
								 getKVPairList1(true);
							 }
						 
							});
				 
				}
			});
			    	
			
			$("#logout").click(function(){
				  authdata="";
				  sessiondata="";
 $.ajax({
            url: main_url+'Logout',
            type: 'POST',
 data: {place:place},
            success: function(data){
			
			
				 
					var boolValue = JSON.parse(data);
					
						if(boolValue){
					 
						clearInterval(interval);
						clearInterval(myVar); 	
						
						$("#divlogoDisplay").show();
						  $("#divappletlogin").show();
						  $("#divappletbody").hide();
						  $("#divheadertable").hide();
						  deleteAllCookies();
						  window.location.reload(true);
						 	 $('#login').prop("disabled", false);
							$('input[type="text"]').css({"border":"1px solid grey","box-shadow":"0 0 5px grey"});
							$('input[type="password"]').css({"border":"1px solid grey","box-shadow":"0 0 5px grey"});
						  
						}else{
							alert("Unable to Logout..!!");
						}
						
						
				 
			 },
            error:function(error){
                console.log('Ajax request error : ' + error);
            }
         });
				
				
			});
			
			
			 function deleteAllCookies() {
				    var cookies = document.cookie.split(";");
				   
				    for (var i = 0; i < cookies.length; i++) {
				        var cookie = cookies[i];
				        var eqPos = cookie.indexOf("=");
				        var name = eqPos > -1 ? cookie.substr(0, eqPos) : cookie;
				        document.cookie = name + "=;expires=Thu, 01 Jan 1970 00:00:00 GMT";
				    }
				    document.cookie.split(";")
					  .forEach(function(c) { 
					  	document.cookie = c.replace(/^ +/, "").replace(/=.*/, "=;expires=" + new Date().toUTCString() + ";path=/"); });

				}
				
			$("#hungup").click(function(){
				$('#hungup').prop("disabled", true);
				$('#hungup').attr("src", "images/Hangup1.png");
			 	talk_dur= document.getElementById("talkEvtTimer").innerHTML;
			 	talk_dur_time=talk_dur;
			 	talk_dur_time= talk_dur_time.substring(3);
				 talk_dur= talk_dur.substring(0,2);
				 var sum= talk_dur*60;
				 talk_dur=parseInt(sum)+parseInt(talk_dur_time);
				 if(talk_dur=="NaN"){
					talk_dur = 0;
				 }
				 
			
				myTimer();
				var jsDate = new Date();
				call_end = jsDate.getFullYear() + "-"+((jsDate.getMonth()) < 10 ? "0" + (jsDate.getMonth() + 1) : jsDate.getMonth() + 1) + "-"+ (jsDate.getDate() < 10 ? "0" + jsDate.getDate() : jsDate.getDate()) +  " " + jsDate.getHours() + ":" + jsDate.getMinutes() + ":" + (jsDate.getSeconds() < 10 ? "0" + jsDate.getSeconds() : jsDate.getSeconds());
			
			  $.ajax({
            url: main_url+'Hungup',
            type: 'POST',
            data: {place:place,isdial:dialenabled},
            success: function(data){
			 
					var boolValue = JSON.parse(data);
					//alert(boolValue);
						if(boolValue){
						 StatusFunc('WrapupDuration','Orange');
						 TalkTimeFunc('CallEnd','Red');
						 
							$('#hungup').prop("disabled", true);
							$('#hold').prop("disabled", true);
							$('#release').prop("disabled", true);
							//$('#mute').prop("disabled", true);
							$('#save').prop("disabled", false);
							$('#dispid').prop("disabled", false);
							$('#subdispid').prop("disabled", false);
							$('#dncdispid').prop("disabled", false);
							
							$('#hungup').attr("src", "images/Hangup1.png");
							$('#hold').attr("src", "images/Hold1.png");
							$('#release').attr("src", "images/Unhold v2.png");
							 
							$('#save').attr("src", "images/Save_Image.png");
							
						}else{
							$('#hungup').prop("disabled", false);
							$('#hungup').attr("src", "images/Hangup.png");
						}
						
				  },
            error:function(error){
                console.log('Ajax request error : ' + error);
            }
         });
				
				
			});
			
			
			
			
			
$("#ready").click(function(){
	 tt=true;
	 clearInterval(switchsession);
$('#ready').attr("src", "images/ready2.png");
		$('#ready').prop("disabled", true);
 $.ajax({
            url: main_url+'Ready',
            type: 'POST',
            data: {place:place},
            success: function(data){
               
			  		var boolValue = JSON.parse(data);
			
				if(boolValue){
					StatusFunc('IdleDuration','Yellow');
					 $("#customerTable").html("");
		        		$("#customerTable").show();
		        		$("#customerTable").append('<div style="height: 387px; line-height: 350px;">' + 
			    		'<h1 id="customerBody" style="color: green; text-align: center; font-size: 50px;">Waiting For Call</h1>' +
			    		'</div>');
					
					tt=true;
					 document.getElementById('nreason').value='';
				
				console.log("***Outside notreadyaux(((-------------)))"+notreadyaux);
					myVar = setInterval(myTimer, 1600);
					savecall=false;
					
					check_ready=true;
				 
					$('#ready').prop("disabled", true);
				 
					$('#nready').prop("disabled", false);
				
					$('#ready').attr("src", "images/ready2.png");
					$('#nready').attr("src", "images/nready.png");
				}else{
					$('#ready').attr("src", "images/ready2.png");
					$('#ready').prop("disabled", true);
				} 
			   
			   	
            },
            error:function(error){
                console.log('Ajax request error : ' + error);
            }
         });
         
  tt=true;
 
    
	});
	



 function ready_save(){
	 tt=true;
	
$('#ready').attr("src", "images/ready2.png");
		$('#ready').prop("disabled", true);
 $.ajax({
            url: main_url+'Ready',
            type: 'POST',
            data: {place:place},
            success: function(data){
               
			  		var boolValue = JSON.parse(data);
			  		
				if(boolValue){
					 StatusFunc('IdleDuration','Yellow');
					 $("#customerTable").html("");
		        		$("#customerTable").show();
		        		$("#customerTable").append('<div style="height: 387px; line-height: 350px;">' + 
			    		'<h1 id="customerBody" style="color: green; text-align: center; font-size: 50px;">Waiting For Call</h1>' +
			    		'</div>');
					
					tt=true;
					 document.getElementById('nreason').value='';
				 
					savecall=false;
					
					check_ready=true;
				 
					$('#ready').prop("disabled", true);
				 
					$('#nready').prop("disabled", false);
				
					$('#ready').attr("src", "images/ready2.png");
					$('#nready').attr("src", "images/nready.png");
				}else{
					$('#ready').attr("src", "images/ready2.png");
					$('#ready').prop("disabled", true);
				} 
			   
			   	
            },
            error:function(error){
                console.log('Ajax request error : ' + error);
            }
         });
         
  tt=true;
 
    
	} 
function mk(){
	
	 
	
	var callDetailsXmlData = "";
	var td1 = "";
	var td2 = "";
	var td3 = "";
	var td4 = "";
	var labelName1 = "";
	var labelValue1 = "";
	var labelName2 = "";
	var labelValue2 = "";
	
	agentName = $("#agentName").val();
	agentID = agentName;
	//closeWindow();
	var tempCustomerID = 0;
	var batchID = 0;
	if(CustomerDetails != null && CustomerDetails != "" && typeof CustomerDetails !== "undefined") {
		tempCustomerID = CustomerDetails["CUSTOMERID"];
		batchID = CustomerDetails["BATCHID"];
	}
	
	var processxmlData = "<ROOT><PROCESS><FLDCUSTOMERID>" + tempCustomerID +"</FLDCUSTOMERID>";
	var tableRow = $("#processTable").find("tr");
	var processLength = tableRow.length;
	for(var i = 0; i < processLength; i++) {
		td1 = tableRow.eq(i).find('td:eq(0)');
		td2 = tableRow.eq(i).find('td:eq(1)');
		td3 = tableRow.eq(i).find('td:eq(2)');
		td4 = tableRow.eq(i).find('td:eq(3)');
		
		if(td1 != null && td1 != "" && typeof td1 !== "undefined") {
			if(td1.find("label").attr("id") != null && typeof td1.find("label").attr("id") !== "undefined" && td1.find("label").attr("id") != "")
				labelName1 = td1.find("label").attr("id");
		}
		if(td2 != null && td2 != "" && typeof td2 !== "undefined") {
			if(td2.find("input").val() != null && typeof td2.find("input").val() !== "undefined" && td2.find("input").val() != "") {
				labelValue1 = td2.find("input").val();
			} else if(td2.find("textarea").val() != null && typeof td2.find("textarea").val() !== "undefined" && td2.find("textarea").val() != "") {
				labelValue1 = td2.find("textarea").val();
			} else if(td2.find("select").val() != null && typeof td2.find("select").val() !== "undefined" && td2.find("select").val() != "") {
				labelValue1 = td2.find("select").val();
			}
		}
		
		if(td3 != null && td3 != "" && typeof td3 !== "undefined") {
			if(td3.find("label").attr("id") != null && typeof td3.find("label").attr("id") !== "undefined" && td3.find("label").attr("id") != "")
				labelName2 = td3.find("label").attr("id");
		}
		if(td4 != null && td4 != "" && typeof td4 != "undefined") {
			if(td4.find("input").val() != null && typeof td4.find("input").val() !== "undefined" && td4.find("input").val() != "") {
				labelValue2 = td4.find("input").val();
			} else if(td4.find("textarea").val() != null && typeof td4.find("textarea").val() !== "undefined" && td4.find("textarea").val() != "") {
				labelValue2 = td4.find("textarea").val();
			} else if(td4.find("select").val() != null && typeof td4.find("select").val() !== "undefined" && td4.find("select").val() != "") {
				labelValue2 = td4.find("select").val();
			}
		}
		// MTK
		 
		if((labelName1 != "" && labelValue1 != "") && (typeof labelName1 !== "undefined" && typeof labelValue1 !== "undefined") && (labelName1 != null && labelValue1 != null)) {
			processxmlData += "<" + labelName1 + "><![CDATA[" + replaceChars(labelValue1) + "]]></" + labelName1 + ">";
			//alert("labelName1m"+labelName1+"labelValue1m="+labelValue1);
		
			if(labelName1=="FLDFILLER1"){
				var FLD4=labelValue1; //PTPAmount,PTPdate
				document.getElementById("fld4").value=FLD4;
				//alert("Fld4="+PTPAmount);
			}
			
			if(labelName1=="FLDFILLER3"){
				var PTPAmount=labelValue1; //PTPAmount,PTPdate
				document.getElementById("p2pamount").value=PTPAmount;
				//alert("Amount="+PTPAmount);
			}
			labelName1 = "";
			labelValue1 = "";
		}
		
		if((labelName2 != "" && labelValue2 != "") && (typeof labelName2 !== "undefined" && typeof labelValue2 !== "undefined") && (labelName2 != null && labelValue2 != null)) {
			processxmlData += "<" + labelName2 + "><![CDATA[" + replaceChars(labelValue2) + "]]></" + labelName2 + ">";
			//alert("labelName2m"+labelName2+"labelValue2m="+labelValue2);
			if(labelName2=="FLDFILLER2"){
				var PTPdate=labelValue2;
				document.getElementById("p2pdate").value=PTPdate;
				//alert("Date="+PTPdate);
			}
			labelName2 = "";
			labelValue2 = "";
		}
	}
	processxmlData += "</PROCESS>";
	processxmlData += "</ROOT>";
	
	
}

			$("#save").click(function(){
				
			
			 wrap_dur= document.getElementById("currentTimer").innerHTML;
			 wrap_dur_time=wrap_dur;
			 
				wrap_dur_time= wrap_dur_time.substring(3);
			 
				 wrap_dur= wrap_dur.substring(0,2);
				 var sum= wrap_dur*60;
				 wrap_dur=parseInt(sum)+parseInt(wrap_dur_time);
				 
				 if(wrap_dur=="NaN"){
					wrap_dur = 0;
				 }
			 
			 
			 //alert(wrap_dur);
				var agentRemarks = $("#agentRemarks").val();
				var language = $("#language option:selected").val();
				var value = $("#disposition option:selected").val();
				var value1 = $("#subDisposition option:selected").val();
				
				var callbacktype1=$("#cbtype option:selected").val();
				var date1=$("#callbackdatetimepicker").val();
				var callBackNumber=$("#callBackNumber").val();
				var notrea=$("#nreason option:selected").val();
				
				
				if (value==null || value==""){  
					  alert("disposition can't be blank");  
					  return false;  
					}
			   if (agentRemarks==null || agentRemarks==""){  
					  alert("AgentRemarks can't be blank");  
					  return false;  
					}	
				 agentRemarks = CryptoJS.AES.encrypt(agentRemarks, secret);
				 agentRemarks = agentRemarks.toString();
				  
				 callBackNumber = CryptoJS.AES.encrypt(callBackNumber, secret);
				 callBackNumber = callBackNumber.toString();
				  
			
				var cbtype1='0';
				var datum;
				//alert("value::"+value+"  value1:::"+value1);
				if(value =='Call Back'){
					cbtype1='1'
					date1=date1+":00";
					date1=date1.replace(/-/g," ");
					datum = Date.parse(date1);
					datum = datum/1000;
					console.log(datum); 
				}
				  
				   mk();
				if(value == "Promise to pay" ){
					
				 
					var cti_P2P_Amount=document.getElementById("p2pamount").value;
					var cti_P2P_Date=document.getElementById("p2pdate").value;
					var FLD4 =document.getElementById("fld4").value;
					
					 if (cti_P2P_Amount==null || cti_P2P_Amount==""){  
						  alert("P2P_Amount can't be blank");  
						  return false;  
						}
					 if (cti_P2P_Date==null || cti_P2P_Date==""){  
						  alert("cti_P2P_Date can't be blank");  
						  return false;  
						}
					 if (FLD4==null || FLD4==""){  
						  alert(" Select PTP MODE ");  
						  return false;  
						}	
				}else{
					document.getElementById("p2pamount").value='';
					document.getElementById("p2pdate").value='';
					document.getElementById("fld4").value='';
				
				}
				 
				
				var wordlist = campname.split("_");
				if(wordlist.includes("LAMS") || wordlist.includes("Click2Call")  ){
					 if (confirm('Are you going to final save? ')) {
						  console.log('yes');
					} else {
					  console.log('no');
					  return false;
					} 
				}
				document.getElementById("save").disabled = true;
				saveHistoryData(value,value1);
				//update_ctidata();
				$('#save').prop("disabled", true);
				
				$.post(main_url+"Save",{disposition: value,cbtype:cbtype1,date:datum,callbacktype:callbacktype1,isdial:dialenabled,subdisposition:value1,place:place,agentRemarks:agentRemarks,language:language,cti_P2P_Amount:cti_P2P_Amount,cti_P2P_Date:cti_P2P_Date, FLD4:FLD4,callBackNumber:callBackNumber,reason:notrea,customer_ID:customer_ID,service_ID:service_ID,delinquency_ID:delinquency_ID,Account_ID:Account_ID},
							function(data) {
					clearInterval(myVar); 
					myVar = setInterval(myTimer, 1600);
					var boolValue = JSON.parse(data);
					if(boolValue){
						
						document.getElementById("recall").style.display ="none";
						//alert("Call Save Successfully");
					 
					var wordlist_data = campname.split("_");
					if(wordlist_data.includes("LAMS") || wordlist_data.includes("CVE") ){
						closeWindow();
						//document.getElementById("yonowindow").style.display ="none";
					}
					if(wordlist_data.includes("YONO") || wordlist_data.includes("CSAT") || wordlist_data.includes("DSAT") ){
						closeWindow();
						document.getElementById("yonowindow").style.display ="none";
					}
					if(wordlist_data.includes("SMS") || wordlist_data.includes("HLWC")){
						closeWindow();
					}
					if(wordlist_data.includes("Click2Call")  ){
						document.getElementById("copynumber99").style.display ="none";
					}
					
					
					document.getElementById("campname_id").value="";
				
					if(boolValue){
						
						
						savecall=true;
						updateData=true;
						dialenabled=false;
						$('#save').prop("disabled", true);
						$('#cbtype').prop("disabled", true);
						$('#callbackdatetimepicker').prop("disabled", true);
						$("#disposition").val(""); //manjit
						$("#subDisposition").val(""); //manjit
						$("#callbackdatetimepicker").val(""); //manjit
						$("#callBackNumber").val(""); //manjit
						$("#historyshowdata").hide();
						document.getElementById("CallbackStatus").innerHTML= ' ';
						document.getElementById("language").value="";
						
						
							$("#navigationtabs").html("");
							 $("#navigationtabs").hide();
							 $("#processTable").html("");
							 $("#processTable").hide();
							 $("#historydata").hide();
				        	 $("#agentscriptslinks").hide();
				            $("#bottomdiv").hide();
							myTimer();
							setTimeout(function(){ GetAgentCallBackCount(); }, 1000);
							setTimeout(function(){ getAgentStatusdata(); }, 1000);
							
						 $("#customerTable").html("");
			        		$("#customerTable").show();
			        		$("#customerTable").append('<div style="height: 387px; line-height: 350px;">' + 
				    		'<h1 id="customerBody" style="color: orange; text-align: center; font-size: 50px;">Waiting For Next Call</h1>' +
				    		'</div>');
					
					  ff=true; 
					  tt=true;
					  
					  if(notrea=="" || notrea==null ){
						  $("#customerTable").html("");
			        		$("#customerTable").show();
			        		$("#customerTable").append('<div style="height: 387px; line-height: 350px;">' + 
				    		'<h1 id="customerBody" style="color: green; text-align: center; font-size: 50px;">Waiting For Next Call</h1>' +
				    		'</div>');
			        		ready_save();
							//$("#ready").click();
			        	
						}else{
							notreadyaux=true;
							StatusFunc('NotReadyDuration','Red');
							$("#customerTable").html("");
			        		$("#customerTable").show();
			        		$("#customerTable").append('<div style="height: 387px; line-height: 350px;">' + 
				    		'<h1 id="customerBody" style="color: orange; text-align: center; font-size: 50px;">Click to Ready</h1>' +
				    		'</div>');
						}
							$("#nreason").val("");
							
					  Scrt=""; 
					      hold_dur="";
						   wrap_dur="";
						   talk_dur="";
						    hold_dur_time="";
							 wrap_dur_time="";
							 talk_dur_time="";
							 customer_ID="";
							 service_ID="";
							 Account_ID="";
							 delinquency_ID="";
						document.getElementById("p2pamount").value='';
						document.getElementById("p2pdate").value='';
						document.getElementById("fld4").value='';
						lobDetails="";
						call_end="";
						call_start="";
						$('#save').prop("disabled", true);
						 
						dail_no="";	
						savecall=false;
						
						
					}else{
						savecall=false;
					 
						
					}
					 document.getElementById('nreason').value=''; 
					
					$("#navigationtabs").html("");
					 $("#navigationtabs").hide();
					 $("#processTable").html("");
					 $("#processTable").hide();
					 $("#historydata").hide();
		        	$("#agentscriptslinks").hide();
		        	$("#bottomdiv").hide();
		        		
					}else{
						alert("Call is not Save Successfully");
						document.getElementById("recall").style.display ="none";
					}
					
				});
			});
			
			
	$("#hold").click(function(){
	
				myTimer();
				timer=null;
 
	
				
			 $.ajax({
            url: main_url+'Hold',
            type: 'POST',
            data: {place:place},
            success: function(data){
				 
				 
					var boolValue = JSON.parse(data);
					if(boolValue){
						
						$('#hold').prop("disabled", true);
						document.getElementById("hold").disabled = true;
								$('#hold').attr("src", "images/Hold v2.png");
								$('#release').prop("disabled", false);
								$('#release').attr("src", "images/Unhold.png");
								 StatusFunc('HoldDuration', 'Gray');
					document.getElementById("hold").disabled = true;
					}else{
						alert("Call is not going on Hold");
					}
						},
            error:function(error){
                console.log('Ajax request error : ' + error);
            }
         });
				 
				
			});	
			
			    $("#release").click(function(){
				
				
				 $.ajax({
	            url: main_url+'UnHold',
	            type: 'POST',
	            data: {place:place},
	            success: function(data){
			
			 
					var boolValue = JSON.parse(data);
					if(boolValue){
						
						 hold_dur=document.getElementById("currentTimer").innerHTML;
						 hold_dur_time=hold_dur;
							hold_dur_time= hold_dur_time.substring(3);
							 hold_dur= hold_dur.substring(0,2);
							 var sum= hold_dur*60;
							 hold_dur=parseInt(sum)+parseInt(hold_dur_time);
							 if(hold_dur=="NaN"){
								hold_dur = 0;
							 }
							 
						 document.getElementById("release").disabled = true;
						$('#release').prop("disabled", true);
						$('#release').attr("src", "images/Unhold v2.png");
						$('#hold').prop("disabled", false);
						$('#hold').attr("src", "images/Hold.png");
						myTimer();
						var data99="";
						StatusFunc('CallDuration','antiquewhite');
					}else{
						alert("Call is not going on UnHold");
					}
				       },
            error:function(error){
                console.log('Ajax request error : ' + error);
            }
         });	
				 
			//	 clearInterval(timer);	
			//	 timer = null;
			//	 document.getElementById('HoldDuration3').innerHTML="00:00";
			});
			
		
			    $( "#nreason" ).change(function() {
					
			    	if(obj.AgentStat=='Established')
					{
						alert("Call is Established");
					}
					 
					
					 
	});
			
			    
				//notready click event
				 $("#nready").click(function(){
				 var checknreason = document.getElementById('nreason').value;
				 if(checknreason =="" || checknreason ==null ){ 
					 alert("Please Select reason..!!");
				 } else {
					 
				 
					
					
					$('#nready').attr("src", "images/nready1.png");
					var notrea=$("#nreason option:selected").val();
					
			   //	alert(notrea);
			
			 $.ajax({
			            url: main_url+'NotReady',
			            type: 'POST',
			 data: {place:place,reason:notrea},
			            success: function(data){
					 
						 
						$("#navigationtabs").hide();	 
					 
							var boolValue = JSON.parse(data);
					 
			              	if(boolValue){
			              		StatusFunc('NotReadyDuration','Red');
								$('#nready').prop("disabled", true);
			              		notreadyaux=true;
								 		$('#ready').prop("disabled", false);
										$('#ready').attr("src", "images/Ready.png");
										 document.getElementById('nreason').value='';	
										 $("#customerTable").html("");
							        		$("#customerTable").show();
							        		$("#customerTable").append('<div style="height: 387px; line-height: 350px;">' + 
								    		'<h1 id="customerBody" style="color: orange; text-align: center; font-size: 50px;">Click Ready</h1>' +
								    		'</div>');
										
									}else{
										$('#nready').prop("disabled", false);
										$('#nready').attr("src", "images/nready.png");
									}  
										myTimer();
			            },
			            error:function(error){
			                console.log('Ajax request error : ' + error);
			            }
			 
				 });
	         
	     
	    
				 }
	});
		
		});
		

	//manjitk		
		function getStaticsData(){
			var boolValue=false;
			var obj1 ="";
			  $.ajax({
        url: main_url+'AGENTSTAT',
        type: 'POST',
        data: {place:place},
        success: function(data){
			 try{
        	if(data.length){
				
				 var obj1 = JSON.parse(data);
				 
					 
				 boolValue=obj1.stat;
					 if(boolValue){
					   var InboundCalls1=JSON.parse(obj1.InboundCalls);
					   console.log("---------------"+InboundCalls1);
					//   alert(JSON.stringify(obj1));
					   console.log(obj1.LoginDuration);
					   
				var LoginDuration =  obj1.LoginDuration;
				 
				 document.getElementById("loginHours1").value=LoginDuration;
				//	console.log("---------------"+LoginDuration);
					var ReadyDuration =  obj1.ReadyDuration;
						
					var OutboundCalls = obj1.OutboundCalls;
					var TalkDuration =  obj1.TalkDuration;
					var AverageHandlingTime= obj1.AverageHandlingTime;
					
					var HoldDuration = obj1.HoldDuration;
					var WrapDuration =  obj1.WrapDuration;
					var ReadyDurations= obj1.ReadyDuration;
					var NotReadyDuration1 = obj1.NotReadyDuration;
					var productiveTime =obj1.Productivity;
				 	var lunchTime=obj1.TotalNotReadyLunch;
				 	
				 document.getElementById("productiveTime999").value=productiveTime;
				 document.getElementById("NotReadyDuration1").value=NotReadyDuration1;
				 document.getElementById("ReadyDuration1").value=ReadyDurations;
				 document.getElementById("lunchTime99").value=lunchTime;
				 
				 document.getElementById("HoldDuration33").value=HoldDuration;
				 document.getElementById("WrapDuration33").value=WrapDuration;
				 
				 
					document.getElementById("OutboundCalls1").value=OutboundCalls;
				 document.getElementById("TalkDuration1").value=TalkDuration;
					 }	
			}  	
			 } catch (err) {
					console.log('Oops, unable to work getStaticsData Function');
				  }  
			 },
        error:function(error){
            console.log('Ajax request error : ' + error);
        }
     });
			
			
		}

			function saveHistoryData(value,value1){
				var disp =value;
					//var subdisp =value1;
					
				//var disp = document.getElementById("disposition").value;// $("#disposition option:selected").val();
				var subdisp = document.getElementById("subDisposition").value;//$("#subDispo option:selected").val();
				var date1=document.getElementById("callbackdatetimepicker").value//$("#callbackdatetimepicker").val();
				var subProcessName1=document.getElementById("subprocess_data").value;
				var AgentName=document.getElementById("agentNamedata").value;
				var number= document.getElementById("number_data").value; 
				 
				/* AgentName = btoa(AgentName);
				 number = btoa(number);
				 disp = btoa(disp);
				 subdisp = btoa(subdisp);
				 subProcessName1 = btoa(subProcessName1); */
				 
				/*  AgentName = CryptoJS.AES.encrypt(AgentName, secret);
				  AgentName = AgentName.toString();
				 
				  number = CryptoJS.AES.encrypt(number, secret);
				  number = number.toString();
				
				  disp = CryptoJS.AES.encrypt(disp, secret);
				  disp = disp.toString();
				  
				  subdisp = CryptoJS.AES.encrypt(subdisp, secret);
				  subdisp = subdisp.toString();
				  
				  subProcessName1 = CryptoJS.AES.encrypt(subProcessName1, secret);
				  subProcessName1 = subProcessName1.toString(); */
					
				var cbtype='NO';
				
				if(disp =='Call Back'){
					cbtype='YES'
				}
				var agentRemarks = $("#agentRemarks").val();
				
				var param = "disp=" + disp + "&subdisp="+subdisp+ "&date="+date1+ "&subProcessName="+subProcessName1+ "&AgentName="+AgentName+ "&number="+number+ "&cbtype="+cbtype+"&remarks="+agentRemarks;
			 
				$.ajax({
		            url: 'CallHistory',
		            type: 'POST',
		            data: "disp=" + disp + "&subdisp="+subdisp+ "&date="+date1+ "&subProcessName="+subProcessName1+ "&AgentName="+AgentName+ "&number="+number+ "&cbtype="+cbtype+"&remarks="+agentRemarks,
		            success: function(data){
					
			 
						
								
						 
					 },
		            error:function(error){
		                console.log('Ajax request error : ' + error);
		            }
		         });

					 
						
			}
			
			
			function myTimer() {
				 
			
				   $.ajax({
			            url: main_url+'Callstate',
			            type: 'POST',
			            data: {place:place,authdata:authdata,sessiondata:sessiondata,user:username},
			        	
			            success: function(data){
			      try{     
			   
					 obj=JSON.parse(data);
				 
					 
					var boolValue = JSON.parse(obj.stat);
					
					console.log("Callstate "+boolValue);
					console.log("lastupdate+boolValue "+lastupdate+obj.AgentStat);
					var c=lastupdate+''+obj.AgentStat;
					$('#lname').val(obj.AgentStatDisplay);
					
				
					if(obj.AgentStat=='Ready' ){
						
						if(ff){
							document.getElementById("recall").style.display ="none";
							Scrt="";
					StatusFunc('IdleDuration','Yellow');
						 ff=false;
						 tt=true;
						
						}
						
					}

			    	if(obj.AgentStat=='Offline') 
					{
			    		
				    		  window.location.reload(true);
				    		  authdata="";
							  sessiondata="";
		
					}
			    	if(obj.AgentStat=='Offline ') 
					{
			    		
			    		 myTimer();
				    		 
		
					}
				
					if(obj.AgentStat=='Established' ){
							if(updateData){
								document.getElementById("recall").style.display ="inline-block";
								clearInterval(myVar); 
								myVar = setInterval(myTimer, 3000);
								var jsDate = new Date();
						    	 call_start = (jsDate.getDate() < 10 ? "0" + jsDate.getDate() : jsDate.getDate())  + "-" + ((jsDate.getMonth()) < 10 ? "0" + (jsDate.getMonth() + 1) : jsDate.getMonth() + 1) + "-" + jsDate.getFullYear() + " " + jsDate.getHours() + ":" + jsDate.getMinutes() + ":" + (jsDate.getSeconds() < 10 ? "0" + jsDate.getSeconds() : jsDate.getSeconds());
						    	 call_start = jsDate.getFullYear() + "-"+((jsDate.getMonth()) < 10 ? "0" + (jsDate.getMonth() + 1) : jsDate.getMonth() + 1) + "-"+ (jsDate.getDate() < 10 ? "0" + jsDate.getDate() : jsDate.getDate()) +  " " + jsDate.getHours() + ":" + jsDate.getMinutes() + ":" + (jsDate.getSeconds() < 10 ? "0" + jsDate.getSeconds() : jsDate.getSeconds());
								 
								 $('#save').prop("disabled", true);
								  if(obj.cti_Disposition == 'Call Back'){
									    document.getElementById("CallbackStatus").innerHTML= 'Preview Call Back';
								  }
								  
						  
					     StatusFunc('CallDuration','antiquewhite');
						 TalkTimeFunc('CallEstablish','antiquewhite')
						 if(obj.FLD2=="undefind" ||  obj.cti_delinquency=="undefind"){
							 obj.FLD2="1"; 
							 obj.cti_delinquency="Irrgular";
						 }
						 customer_ID=obj.cti_Application_Number;
						 service_ID=obj.FLD2;
						 delinquency_ID= obj.cti_delinquency;
						 Account_ID=obj.cti_Account_No;
						 campname = obj.GSW_CAMPAIGN_NAME;
						 
						 	var countTotal = campname.split("_");
							if(countTotal.includes("PAPL")){
							document.getElementById("count").value=30;
							}else{
								document.getElementById("count").value=10;
							}	
							
						 var words_BLASTER = campname.split("_");	
							if(words_BLASTER.includes("BLASTER")){
								
								 DispositionListdata(obj.FLD2);
									 displayCustomerDetailsGenesys(obj);	
									
							}
							else {
					 	 dataGetDB(obj.cti_Application_Number,obj.FLD2);//obj.FLD2 200
							}
					
							$('#hungup').prop("disabled", false);
							$('#mute').prop("disabled", false);
							
							$('#hungup').attr("src", "images/Hangup.png");
							$('#mute').attr("src", "images/Mute.png");
						 
							
							updateData=false;
							
			
							 
							document.getElementById("campname_id").value=campname ;
							document.getElementById("number_data").value=obj.number;
							
							dail_no =obj.number;
								// Click2Call
								
							var words = campname.split("_");
							if(words.includes("Click2Call")){
								document.getElementById("copynumber99").style.display ="inline-block";
							}
							if(words.includes("LAMS")){
										
								var username=document.getElementById("agentNamedata").value;
								 var delinquency=obj.cti_delinquency;//"IRREGULAR";
								 var acno =obj.cti_Account_No;//"31030371876";
								 var MobNo=document.getElementById("mobileNumber99").value;
								 
								var inputaparams="TYPE=LAMPS&acno="+acno+"&delinquency="+delinquency+"&LoginID="+username+"&SSOKEY="+ssokey+"&Userid="+ username+"&MobNo="+MobNo; 
														
								//$('#disposition').empty();
								//$("#disposition").append('<option value="" selected="true" disabled="disabled">-- Please Select --</option><option value="Already Paid"  id="LAMS_TEST1" >Already Paid</option><option value="Already Received Call" id="LAMS_TEST1" >Already Received Call</option><option value="Auto Wrap" id="LAMS_TEST1">Auto Wrap</option><option value="Auto Wrap_No Contact" id="LAMS_TEST1">Auto Wrap_No Contact</option><option value="Call Disconnect" id="LAMS_TEST1">Call Disconnect</option><option value="Dispute" id="LAMS_TEST1">Dispute</option><option value="Early Warning" id="LAMS_TEST1">Early Warning</option><option value="Foreclosure" id="LAMS_TEST1">Foreclosure</option><option value="Irregular Reason" id="LAMS_TEST1">Irregular Reason</option><option value="Miscellaneous Reason" id="LAMS_TEST1">Miscellaneous Reason</option><option value="Not Contactable" id="LAMS_TEST1">Not Contactable</option><option value="Other Positive Talk" id="LAMS_TEST1">Other Positive Talk</option><option value="Promise to pay" id="LAMS_TEST1">Promise to pay</option><option value="refuse To Pay" id="LAMS_TEST1">refuse To Pay</option><option value="Service Unavailable" id="LAMS_TEST1">Service Unavailable</option><option value="Third Party" id="LAMS_TEST1">Third Party</option><option value="Right Party" id="LAMS_TEST1">Right Party</option><option value="Successful" id="LAMS_TEST1">Successful</option><option value="Wrong Number" id="LAMS_TEST1">Wrong Number</option>      <option value="Call Back" id="LAMS_TEST1">Call Back</option>');
							
								
								
							   $.ajax({
						            url: 'GetRefLamps',
						            type: 'GET',
						            contentType: "application/json; charset=utf-8",
						            async:false,
						            data: inputaparams,
						            success: function(jsondata){
						           
											  showWindow($.trim(jsondata));
										
												 isWindowOpen=true;
						            }
						         });	
							
								}
							
							var words_YONO = campname.split("_");	
							if(words_YONO.includes("YONO")){	
									var username=document.getElementById("agentNamedata").value;
									 var Number =obj.number;//"31030371876";
									 var inputaparams="TYPE=YONO&MobNo="+Number+'&agentID='+username;
								   $.ajax({
							            url: 'GetRefNoServlet',
							            type: 'GET',
							            contentType: "application/json; charset=utf-8",
							            async:false,
							            data: inputaparams,
							            success: function(jsondata){
							            	     yonowindow = jsondata;
												  showWindow($.trim(jsondata));
													 isWindowOpen=true;
													
							            }
							         });	
								   document.getElementById("yonowindow").style.display ="block";
									}
								var words_CSAT = campname.split("_");	
									if(words_CSAT.includes("CSAT")){		
										var username=document.getElementById("agentNamedata").value;
									 var Number =obj.number;//"31030371876"; 
									var CTI="CSAT";
								//	var inputaparams="TYPE=CRMNEXT&CTI="+CTI+"&mobileNo="+Number+"&CRMID=11"+"&LoginID="+username+"&SSOKEY="+ssokey+"&Userid="+ username
									var inputaparams="TYPE=CRMNEXT&CTI="+CTI+"&mobileNo="+Number+"&CRMID="+subProcessDetails["SUBPROCESSID"]+"&LoginID="+username+"&SSOKEY="+ssokey+"&Userid="+ username
							 
									 var CrmNextURL="";
									 
									
								   $.ajax({
							            url: 'GetRefNoServlet',
							            type: 'GET',
							            contentType: "application/json; charset=utf-8",
							            async:false,
							            data: inputaparams,
							            success: function(jsondata){
							           
												  showWindow($.trim(jsondata));
											
													 isWindowOpen=true;
							            }
							         });	
								
									}
									var words_DSAT = campname.split("_");	
									if(words_DSAT.includes("DSAT")){		
										var username=document.getElementById("agentNamedata").value;
									 var Number =obj.number;//"31030371876"; 
									var CTI="DSAT";
								//	var inputaparams="TYPE=CRMNEXT&CTI="+CTI+"&mobileNo="+Number+"&CRMID=11"+"&LoginID="+username+"&SSOKEY="+ssokey+"&Userid="+ username
									var inputaparams="TYPE=CRMNEXT&CTI="+CTI+"&mobileNo="+Number+"&CRMID="+subProcessDetails["SUBPROCESSID"]+"&LoginID="+username+"&SSOKEY="+ssokey+"&Userid="+ username
							 
									 var CrmNextURL="";
									 
									
								   $.ajax({
							            url: 'GetRefNoServlet',
							            type: 'GET',
							            contentType: "application/json; charset=utf-8",
							            async:false,
							            data: inputaparams,
							            success: function(jsondata){
							           
												  showWindow($.trim(jsondata));
											
													 isWindowOpen=true;
							            }
							         });	
								
									}
									var words_SMSUNHAPPY = campname.split("_");	
									if(words_SMSUNHAPPY[0].includes("SMS")){		
										var username=document.getElementById("agentNamedata").value;
									 var Number =obj.number;//"31030371876";
									var CTI="SMSUNHAPPY";
									var inputaparams="TYPE=CRMNEXT&CTI="+CTI+"&mobileNo="+Number+"&CRMID="+subProcessDetails["SUBPROCESSID"]+"&LoginID="+username+"&SSOKEY="+ssokey+"&Userid="+ username;
							 
									 var CrmNextURL="";
									
								   $.ajax({
							            url: 'GetRefNoServlet',
							            type: 'GET',
							            contentType: "application/json; charset=utf-8",
							            async:false,
							            data: inputaparams,
							            success: function(jsondata){
							           
												  showWindow($.trim(jsondata));
											
													 isWindowOpen=true;
							            }
							         });	
								
									}
									var words_HLWC = campname.split("_");	
									if(words_HLWC[0].includes("HLWC")){		
										var username=document.getElementById("agentNamedata").value;
									 var Number =obj.number;//"31030371876";
									var CTI="HLWC";
									var inputaparams="TYPE=CRMNEXT&CTI="+CTI+"&mobileNo="+Number+"&CRMID="+subProcessDetails["SUBPROCESSID"]+"&LoginID="+username+"&SSOKEY="+ssokey+"&Userid="+ username;
							 
									 var CrmNextURL="";
									
								   $.ajax({
							            url: 'GetRefNoServlet',
							            type: 'GET',
							            contentType: "application/json; charset=utf-8",
							            async:false,
							            data: inputaparams,
							            success: function(jsondata){
							           
												  showWindow($.trim(jsondata));
											
													 isWindowOpen=true;
							            }
							         });	
								
									}
									var words_CVE = campname.split("_");	
									if(words_CVE.includes("CVE")){		
										var username=document.getElementById("agentNamedata").value;
									 var Number =obj.number;//"31030371876";
									var CTI="CVE";
									  var Number =obj.number;//"31030371876";
									
									var inputaparams="TYPE=CRMNEXT&CTI="+CTI+"&mobileNo="+Number+"&CRMID="+subProcessDetails["SUBPROCESSID"]+"&LoginID="+username+"&SSOKEY="+ssokey+"&Userid="+ username;
									 
									//var inputaparams="TYPE=CRMNEXT&CTI="+CTI+"&mobileNo="+Number+"&CRMID="+subProcessDetails["SUBPROCESSID"]+"&LoginID="+username+"&SSOKEY="+ssokey+"&Userid="+ username
							 
									 var CrmNextURL="";
									 
									
								   $.ajax({
							            url: 'GetRefNoServlet',
							            type: 'GET',
							            contentType: "application/json; charset=utf-8",
							            async:false,
							            data: inputaparams,
							            success: function(jsondata){
							           
												  showWindow($.trim(jsondata));
											
													 isWindowOpen=true;
							            }
							         });	
								
									}		
									
							
						}
						
						else{
							console.log("===========================");
							//$('#release').prop("disabled", true);
							//  document.getElementById("hold").disabled=false;
							//$('#hold').prop("disabled", false);
							document.getElementById("hold").disabled = false;
							
							$('#ready').prop("disabled", true);
							$('#nready').prop("disabled", true);
							$('#hold').attr("src", "images/Hold.png");
							$('#release').attr("src", "images/Unhold v2.png");
						 
							$('#ready').attr("src", "images/ready2.png");
							$('#nready').attr("src", "images/nready1.png");
						 
							
						}
							
						
						
					}
					
			if(obj.AgentStatDisplay=='Not Ready' || obj.AgentStat=="NotReady" || obj.AgentStatDisplay=="Lunch Break" || obj.AgentStatDisplay=='Personal Break' || obj.AgentStatDisplay=='Briefing' || obj.AgentStatDisplay=='BHR Activity' ||   obj.AgentStatDisplay=='TL Feedback' ||  obj.AgentStatDisplay=='Application Down'|| obj.AgentStatDisplay=='Data not available'||     obj.AgentStatDisplay=='TOPS session' ||   obj.AgentStatDisplay=='Quality Feedback' ){
						 
			if(notreadyaux){
				notreadyaux=false;
				console.log("***Call timer notreadyaux(((-------------)))"+notreadyaux);
					clearInterval(myVar);
					timer25min=setInterval(myTimer, (60000*25));
				
			}
			document.getElementById("hold").disabled = true;
			
					$('#ready').prop("disabled", false);
					$('#ready').attr("src", "images/Ready.png");
				 
					$('#nready').prop("disabled", true);
					$('#nready').attr("src", "images/nready1.png");
				//}
			}
			
									//manjit
									if(obj.AgentStatDisplay=='AfterCallWork'){
										
										
										$('#ready').prop("disabled", true);
									 Scrt = "AfterCallWork";
										console.log("==================AfterCallWork==========="+tt);
										if(tt){
											 $("#disposition").append('<option value="Short Call"   >Short Call</option>');	
											document.getElementById("number_data").value=dail_no;
											  StatusFunc('WrapupDuration','Orange');
											 TalkTimeFunc('CallEnd','Red');
											 document.getElementById("recall").style.display ="inline-block"; 
												var jsDate = new Date();
												call_end = jsDate.getFullYear() + "-"+((jsDate.getMonth()) < 10 ? "0" + (jsDate.getMonth() + 1) : jsDate.getMonth() + 1) + "-"+ (jsDate.getDate() < 10 ? "0" + jsDate.getDate() : jsDate.getDate()) +  " " + jsDate.getHours() + ":" + jsDate.getMinutes() + ":" + (jsDate.getSeconds() < 10 ? "0" + jsDate.getSeconds() : jsDate.getSeconds());
											
										 }
										$('#hungup').prop("disabled", true);
											 $('#hungup').attr("src", "images/Hangup1.png");
											 $('#ready').prop("disabled", false);
											$('#ready').attr("src", "images/Ready.png");
										
										
										  tt=false;
										 
										 $('#save').prop("disabled", false);
										$("#bottomdiv").show();
										if($("#save").is(":disabled")){
											$('#ready').prop("disabled", false);
											$('#ready').attr("src", "images/Ready.png");
											 
											$('#nready').prop("disabled", true);
											$('#nready').attr("src", "images/nready1.png");
												}else{
											$('#nready').prop("disabled", false);
											$('#nready').attr("src", "images/nready.png");
											$('#ready').prop("disabled", true);
											$('#ready').attr("src", "images/ready2.png");
										}
											
									}
									if(obj.AgentStatDisplay=='Ready'){
						 
						if(check_ready){
							 	 
							check_ready=false;
						}
						
						 
						
						$('#ready').prop("disabled", true);
						$('#ready').attr("src", "images/ready2.png");
						$('#nready').prop("disabled", false);
						$('#nready').attr("src", "images/nready.png");
						 
					
						$("#bottomdiv").hide();
						 
					}
			            } catch (err) {
							console.log('Oops, unable to work Mytimer Function');
						  }  			
			            },
			            error:function(error){
			                console.log('Ajax request error : ' + error);
			            }
			         });	
			
 
			 
				
				}	
				
				
				
				$(document).on('click', '#customerInfo', function () {
					 
					displayCustomerDetails(CustomerDetails);
				 
		    });
				$(document).on('click', '#customerInfo1', function () {
					 
					displayCustomerDetailsGenesys(obj);
				 
		    });
				
		
				 
				function cti_disp(dispJsonArray) {
					var dispXmlDoc = "";
					$("#disposition").html("");
			    	var dispoptionValues = '<option value="">-- Select --</option>';
		   			if(dispositionXml != null) {
		   				dispXmlDoc = $.parseXML(dispositionXml);
		   				$(dispXmlDoc).find("ROW").each(function() {
		 						dispoptionValues += '<option id="'+ $(this).find("DISPOSITIONID").text() +'" data="'+ $(this).find("DISPOSITIONCODE").text() +'" value="'+ $(this).find("DISPOSITIONNAME").text() +'">'+ $(this).find("DISPOSITIONNAME").text() +'</option>';
		 					 
		 				});
		   	    	}
		   		//	console.log("******************** dispoptionValues *******************************"+dispoptionValues);
			    	$("#disposition").append(dispoptionValues);
				}
			
				function DispositionListdata(serviceID){
					var dispJsonArray = [];
			
					if(serviceID!=""){
					
				 
					 $.ajax({

					        type: "POST",
					        url: "portal",
					     	 
					        data: "opcode=DispositionList&serviceID=" + serviceID,
					        dataType: 'json',
					        async: false,
					        success: function(response) {
					        	
					     
					        	var jsonString = JSON.stringify(response);
					         console.log(jsonString)
					        	var obj3 = JSON.parse(jsonString);
					        	//console.log("-------------DB Data-------"+jsonString);
								sequenceNumber = "";
								  SUBPROCESSID_mk="500";
								  SUBPROCESSNAME_mk ="YONO DROP OFF";
								document.getElementById("subprocess_data").value = "YONO DROP OFF";
							try{
								document.getElementById("subProcess").innerHTML = "500";
							} catch (err) {
								console.log('Oops, unable to work Subprocess Function');
							  }  
							
								if(obj3["dispositions"] != null) {
					        		dispositionXml = obj3["dispositions"];
					        	}
								
								 
								cti_disp(dispositionXml);
					        }
					 });
					 }
				}
				function dataGetDB(customerID,serviceID){
					var dispJsonArray = [];
			
					if(customerID!="" && serviceID!=""){
					
				 
					 $.ajax({

					        type: "POST",
					        url: "portal",
					     	 
					        data: "opcode=customerdetails&customerID=" + customerID + "&serviceID="+serviceID,
					        dataType: 'json',
					        async: false,
					        success: function(response) {
					        	var jsonString = JSON.stringify(response);
					         
					        	var obj3 = JSON.parse(jsonString);
					        	//console.log("-------------DB Data-------"+jsonString);
								sequenceNumber = "";
								LOBDetails = obj3["AgentPortalDetails"]["LOBDetails"];
								labelMapDetails = obj3["AgentPortalDetails"]["labelMapDetails"];
								orderMapDetails = obj3["AgentPortalDetails"]["orderMapDetails"];
								subProcessDetails = obj3["AgentPortalDetails"]["subProcessDetails"];
								processDetails = obj3["AgentPortalDetails"]["processDetails"];
								AgentScriptDetails = obj3["AgentPortalDetails"]["AgentScriptDetails"];
								if(typeof subProcessDetails === "undefined"){
									//document.getElementById("subprocess_data").value ="LAMS_TEST";
								//	console.log("**************subProcessDetails Failed  *************");
									$("#customerTable").html("");
					        		$("#customerTable").show();
					        		$("#customerTable").append('<div style="height: 408px; line-height: 350px;">' +
					        		'<h1 id="customerBody" style="color: red; text-align: center; font-size: 50px;">Data Fetch Failed</h1>' +
					        		'</div>');
					        		
								}else{
									document.getElementById("subprocess_data").value = subProcessDetails["SUBPROCESSNAME"];
								}
								
								CustomerDetails = obj3["AgentPortalDetails"]["CustomerDetails"];
								if(obj3["dispositions"] != null) {
					        		dispositionXml = obj3["dispositions"];
					        	}
								
								 
								cti_disp(dispositionXml);
								
					        	if(obj3 != null && obj3["AgentPortalDetails"]["customerStatus"] == "Success") {
									CustomerDetails = obj3["AgentPortalDetails"]["CustomerDetails"];
									 
								 
									var jsDate = new Date();
							    	var jsLogDateTime = (jsDate.getDate() < 10 ? "0" + jsDate.getDate() : jsDate.getDate())  + "-" + ((jsDate.getMonth()) < 10 ? "0" + (jsDate.getMonth() + 1) : jsDate.getMonth() + 1) + "-" + jsDate.getFullYear() + " " + jsDate.getHours() + ":" + jsDate.getMinutes() + ":" + (jsDate.getSeconds() < 10 ? "0" + jsDate.getSeconds() : jsDate.getSeconds());
							    	
									displayLOBDetails(LOBDetails);
									var cust = JSON.stringify(CustomerDetails)
									 $("#navigationtabs").show();
									$("#navigationtabs").html("");
						            var navtabs = '<ul id="navigation" class="navigation">' +
								    '<li><span id="customerInfo">Customer Information</span></li>' +
								    '<li><span id="lobInfo" data="' + processDetails["PROCESSID"] + '" style="">' + processDetails["PROCESSNAME"] + '</span></li>' +
								    '<li><span id="callHistoryInfo">Call History</span></li>' +
								    '<li><span id="agentScripts">Agent Scripting</span></li>' +
								    '<label id="subProcess" data="' + subProcessDetails["SUBPROCESSID"] + '">' + subProcessDetails["SUBPROCESSNAME"] + '</label>' +
									'</ul>';
									$("#navigationtabs").append(navtabs);
									
									if(subProcessDetails != null && subProcessDetails != "" &&  typeof subProcessDetails !== "undefined") {
										subProcessID = $("#subProcess").attr("data");
									}
									$("#agentstatsinfo").show();
								
									var scriptObject = [];
									var scriptlinks = "";
									var defaultscriptlink = "";
									if(AgentScriptDetails != null && AgentScriptDetails != "" && typeof AgentScriptDetails !== "undefined" ) {
										var scriptsLength = AgentScriptDetails.length;
										for(var i = 0; i < scriptsLength; i++) {
											scriptObject.push(AgentScriptDetails[i]);
										} 
										
										var scriptlength = scriptObject.length;
										for(var k = 0; k < scriptlength; k++) {
											if(AgentScriptDetails[k]["scriptDefault"] == 1) {
												defaultscriptlink += '<a href="#" class="scriptlinks" data="' + AgentScriptDetails[k]["scriptName"] +'">' + AgentScriptDetails[k]["scriptName"] + '</a>' + ((scriptlength > 1) ? '<br><br>' : '');
											} 
											if(AgentScriptDetails[k]["scriptDefault"] == 0) {
												scriptlinks += '<a href="#" class="scriptlinks" data="' + AgentScriptDetails[k]["scriptName"] +'">' + AgentScriptDetails[k]["scriptName"] +'</a>';
												if(AgentScriptDetails[k+1] != null) {
													scriptlinks += '<br><br>';
												} 
											}
										}
										$("#agentscriptslinks").append(defaultscriptlink + scriptlinks);
										$("#agentscriptslinks").show();
									}
									
									

									if(CustomerDetails == "" || CustomerDetails == null || typeof CustomerDetails === "undefined" ||  subProcessDetails == "undefined") {
										$("#navigationtabs").html("");
						        		$("#navigationtabs").hide();
						        		$("#processTable").html("");
						        		$("#processTable").hide();
						        		$("#historydata").hide();
						        		$("#historyshowdata").html("");
						        		$("#bottomdiv").show();
						        		$("#agentscriptslinks").html("");
						        		$("#agentscriptslinks").hide();
						        		
						        		// Added on 24-03-2017 LCS
						        		$("#lcstabdata").html("");
						        		$("#lcstabdata").hide();
						        		// Ended
						        		
						        		$("#customerTable").html("");
						        		$("#customerTable").show();
						        		$("#customerTable").append('<div style="height: 408px; line-height: 350px;">' +
						        		'<h1 id="customerBody" style="color: red; text-align: center; font-size: 50px;">Data Fetch Failed</h1>' +
						        		'</div>');
						        		
						        		//numStatus = "Failure";
										//autoNumObject["numStatus"]  = numStatus;
										//autoWrapStatus = "Failure";
										//autoNumObject["autoWrapStatus"]  = autoWrapStatus;
										// Added on 24-03-2017 LCS
										//lcsStatus = "Failure";
										//autoNumObject["lcsStatus"]  = lcsStatus;
										// Added on 29-07-2017 OCAS
										//ocasStatus = "Failure";
										//autoNumObject["ocasStatus"]  = ocasStatus;
									}else{
										
										displayCustomerDetails(CustomerDetails);
									
									}
									 
									
									$("#agentRemarks").removeClass("errorborder");
									$("#callBackNumber").removeClass("errorborder");
									$("#disposition").removeClass("errorborder");
									$("#subDisposition").removeClass("errorborder");
									$("#callBackType").removeClass("errorborder");
									$("#callbackdatetimepicker").removeClass("errorborder");
									
									// Commented on 04-04-2017
									// dispositios(dispJsonArray);
									$("#agentRemarks").val("");
									$("#callbackdatetimepicker").val("");
									$('#bottomdiv input[type="radio"]').each(function () { 
										 $(this).prop('checked', false); 
									});
									 
									
									  
					        	}  
					        },
					        error: function(e){
					        }
						});
					 
				} else{
					$("#navigationtabs").html("");
	        		$("#navigationtabs").hide();
	        		$("#processTable").html("");
	        		$("#processTable").hide();
	        		$("#historydata").hide();
	        		$("#historyshowdata").html("");
	        		$("#bottomdiv").show();
	        		$("#agentscriptslinks").html("");
	        		$("#agentscriptslinks").hide();
	        		
	        		// Added on 24-03-2017 LCS
	        		$("#lcstabdata").html("");
	        		$("#lcstabdata").hide();
	        		// Ended
	        		
	        		$("#customerTable").html("");
	        		$("#customerTable").show();
	        		$("#customerTable").append('<div style="height: 408px; line-height: 350px;">' +
	        		'<h1 id="customerBody" style="color: red; text-align: center; font-size: 50px;">Data Fetch Failed</h1>' +
	        		'</div>');
	        		
					
					 }
										
				}
				

				function GetAgentCallBackCount(){
					
					var AgentName=document.getElementById("agentNamedata").value;
					 
							$.ajax({
					            url: 'CustomeState',
					            type: 'POST',
							 data: {AgentName:AgentName},
					            success: function(data){
					            	
					            //	alert(data);
					            document.getElementById("CallbackAgent").value=data;
								
 },
					            error:function(error){
					                console.log('Ajax request error : ' + error);
					            }
					         });
							myTimer();
							
				}
				function Recall(){
					if(customer_ID!="" && service_ID!=""){ 
					 dataGetDB( customer_ID,service_ID);//obj.FLD2 200
					 $('#save').prop("disabled", false);
						$("#bottomdiv").show();
						if($("#save").is(":disabled")){
							$('#ready').prop("disabled", false);
							$('#ready').attr("src", "images/Ready.png");
							 
							$('#nready').prop("disabled", true);
							$('#nready').attr("src", "images/nready1.png");
								}else{
							$('#nready').prop("disabled", false);
							$('#nready').attr("src", "images/nready.png");
							$('#ready').prop("disabled", true);
							$('#ready').attr("src", "images/ready2.png");
						}
					}
				}
				 
				function getAgentStatusdata(){
					
					
					var AgentName=document.getElementById("agentNamedata").value;
					
					 $.ajax({
							 url: "portal",
					            type: 'POST',
					            data: "opcode=AgentState1&AgentName="+ AgentName,
					            success: function(res){
					            	 var data = JSON.parse(res);
					            	 
					            	 if(data.RIGHTPARTY == undefined || data == "{}" ){
					            		 document.getElementById("rightpartydata").value = "0";
					            	 }else{
					            	 document.getElementById("rightpartydata").value = data.RIGHTPARTY;
					            	 }

					            	 if(data.THIRDPARTY == undefined || data == "{}" ){
						            	 document.getElementById("thirdpatydata").value = "0";
					            	 }else{
					            	 document.getElementById("thirdpatydata").value = data.THIRDPARTY;
					            	 }

					            	 if(data.SUCCESFULL == undefined || data == "{}" ){
						            	 document.getElementById("successfuldata").value = "0";
					            	 }else{
					            	 document.getElementById("successfuldata").value = data.SUCCESFULL;
					            	 }
					            	 
					     	 
								 },
					            error:function(error){
					                console.log('Ajax request error : ' + error);
					            }
					         });
						myTimer();
							
				}
				 

				 
				function update_ctidata() {
					
					
					var jsonCallDispObject="";
					// Added on 11-07-0217
					var jsDate = new Date();
			    	var jsLogDateTime = (jsDate.getDate() < 10 ? "0" + jsDate.getDate() : jsDate.getDate())  + "-" + ((jsDate.getMonth()) < 10 ? "0" + (jsDate.getMonth() + 1) : jsDate.getMonth() + 1) + "-" + jsDate.getFullYear() + " " + jsDate.getHours() + ":" + jsDate.getMinutes() + ":" + (jsDate.getSeconds() < 10 ? "0" + jsDate.getSeconds() : jsDate.getSeconds());
			    	//writeFile.WriteLine(jsLogDateTime + " : Call Details : " +jsonCallDispObject);
					// Ended
					
					var flag = true; 
					var jsonCallDispParse = "";
					
					var agentName = "";
					var agentID = "";
					
					var processID = 0;
					var subProcessID = 0;
					var isDispose = false;
					
			    	var agentRemarks = "";
			    	var dispositionID = 0;
			    	var dispositionCode = "";
			    	var disposition = "";
					var subDispositionID = 0;
					var subDispositionCode = "";
					var subDisposition = "";
			    	var callbackFlag = 0;
			    	var salesFlag = 0;
			    	var exclusionFlag = 0;
			    	var category = "";
			    	var mandatoryFlag = 0;
			    	
			    	var callBackNumber = "";
					var callBackType = "";
					var callBackDateTime = "";
					var language = "";
					var date = "";
					
					var subdispoptioncount = 0;
					var callbackTypeCount = 0;
					var dispositons = "";
					var stringdisp= "";
					
					var idleTime = 0;
					var talkTime = 0;
					var wrapTime = 0;
					var holdTime = 0;
					var previewTime = 0;
					var callStartTime = "";
					var callEndTime = "";
					
					var currDate = new Date();
					var dt = currDate.getDate();
				    var month = currDate.getMonth() + 1; 
				    var year = currDate.getFullYear();
				    if(dt < 10) {
				    	dt = '0' + dt;
					} 
					if(month < 10) {
					    month = '0' + month;
					}
					date = year + "-" + month + "-" + dt;
					
					// Added on 24-03-2017 LCS
					var lcsTokenNo = "";
					
					// Added on 25-03-2017
					var contactFlag = false;
					var notContactFlag = false;
					
					if(CustomerDetails == "" && LOBDetails == "" && AgentScriptDetails == "" && labelMapDetails == "" && orderMapDetails == "" && subProcessDetails == "" && processDetails == "") {
					//	var stringdisp = callbackValidation(jsonCallDispObject);
						return stringdisp;
			    	} else {
			    		
			    		if(jsonCallDispObject != null && jsonCallDispObject != "" && typeof jsonCallDispObject !== "undefined") {
			    			jsonCallDispParse = JSON.parse(jsonCallDispObject);
			    		}
			    		
			    		if(jsonCallDispParse["isDispose"] != "" && jsonCallDispParse["isDispose"] != null && typeof jsonCallDispParse["isDispose"] !== "undefined") {
			    			isDispose = jsonCallDispParse["isDispose"];
						}
			    		
						if(processDetails != null && processDetails != "" &&  typeof processDetails !== "undefined") {
							processID = $("#lobInfo").attr("data");
						}
						if(subProcessDetails != null && subProcessDetails != "" &&  typeof subProcessDetails !== "undefined") {
							subProcessID = $("#subProcess").attr("data");
						}
			    		
						agentRemarks = $("#agentRemarks").val();
						language = $("#language").val();
				    	disposition = $("#disposition").val();
				    	 
				    	 
				    	
				    	 
				    	subDisposition = $("#subDisposition").val();
				    	if(disposition != null && disposition != "" && typeof disposition !== "undefined") {
				    		dispositionID = $("#disposition option:selected").attr("id");
							dispositionCode = $("#disposition option:selected").attr("data");
							
							// Added on 25-03-2017
							 
								if(dispositionXml != null) { //console.log("********dispositionXml******"+dispositionXml);
									var dispXmlDoc = $.parseXML(dispositionXml);
									$(dispXmlDoc).find("ROW").each(function() {
										//if($(this).find("DISPOSITIONCODE").text() == dispositionCode && $(this).find("DISPOSITIONID").text() == dispositionID && $(this).find("DISPOSITIONSTATE").text().toLowerCase() == "Not Contact".toLowerCase()) {
										if($(this).find("DISPOSITIONCODE").text() == dispositionCode && $(this).find("DISPOSITIONSTATE").text().toLowerCase() == "Not Contact".toLowerCase()) {
											contactFlag = true;
										}
									});
									// Commented on 26-06-2017
									/* if(contactFlag) {
										alert("Please select Contact disposition");
										flag = false;
									} */
								
							}

							
							
				    	}
				    	if(subDisposition != null && subDisposition != "" && typeof subDisposition !== "undefined") {
							subDispositionID = $("#subDisposition option:selected").attr("id");
							subDispositionCode = $("#subDisposition option:selected").attr("data");
				    	}
				    	
				    	

				    		var tableRow = $("#processTable").find("tr");
							var processLength = tableRow.length;
							for(var i = 0; i < processLength; i++) {
								td1 = tableRow.eq(i).find('td:eq(0)');
								td2 = tableRow.eq(i).find('td:eq(1)');
								td3 = tableRow.eq(i).find('td:eq(2)');
								td4 = tableRow.eq(i).find('td:eq(3)');
								
								if(td1.find("span").text() == "*") {
									// textfield validation
									if(typeof td2.find("input").val() !== "undefined") {
										if(td2.find("input").val() == null || td2.find("input").val() == "") {
											td2.find("input").addClass("errorborder");
											flag = false;
										} else {
											td2.find("input").removeClass("errorborder");
										}
									} else if(typeof td2.find("select").val() !== "undefined") {
										// dropdown validation
										if(td2.find("select").val() == null || td2.find("select").val() == "") {
											td2.find("select").addClass("errorborder");
											flag = false;
										} else {
											td2.find("select").removeClass("errorborder");
										}
									} else if(typeof td2.find("textarea").val() !== "undefined") {
										// textarea validation
										if(td2.find("textarea").val() == null || td2.find("textarea").val() == "") {
											td2.find("textarea").addClass("errorborder");
											flag = false;
										} else {
											td2.find("textarea").removeClass("errorborder");
										}
									}
								}
								if(td3.find("span").text() == "*") {
									if(typeof td4.find("input").val() !== "undefined") {
										// textfield validation
										if(td4.find("input").val() == null || td4.find("input").val() == "") {
											td4.find("input").addClass("errorborder");
											flag = false;
										} else {
											td4.find("input").removeClass("errorborder");
										}
									}
									if(typeof td4.find("select").val() !== "undefined") {
										// dropdown validation
										if(td4.find("select").val() == null || td4.find("select").val() == "") {
											td4.find("select").addClass("errorborder");
											flag = false;
										} else {
											td4.find("select").removeClass("errorborder");
										}
									}
									if(typeof td4.find("textarea").val() !== "undefined") {
										// textarea validation
										if(td4.find("textarea").val() == null || td4.find("textarea").val() == "") {
											td4.find("textarea").addClass("errorborder");
											flag = false;
										} else {
											td4.find("textarea").removeClass("errorborder");
										}
									}
								}
							}
				    	
				    	
				    	if(callbackFlag == 1) {
				    		callBackNumber = $("#callBackNumber").val();
				    		// Added on 29-11-2017 for mask dial no's
							if(callBackNumber.indexOf("XXXX") == -1) {
								callBackNumber = $("#callBackNumber").val();
							} else {
								callBackNumber = dialNumber;
							}
							callBackDateTime = $("#callbackdatetimepicker").val();
							
				    		 callBackType = $("#callBackType").val();
				    		
				    		 
				    		
				    		 
					    }
			    	}
					
					if(dispositionXml != null) {
						
					//console.log("********dispositionXml******"+dispositionXml);
						var dispXmlDoc = $.parseXML(dispositionXml);
						$(dispXmlDoc).find("ROW").each(function() {
							if(dispositionCode != "" && dispositionCode != null) {
								if($(this).find("DISPOSITIONCODE").text() == dispositionCode) {
			 						category = $(this).find("FINAL").text();
			 					}
							}
		 				});
					}
					 
			    	if(true) {
					var callDetailsXmlData = "";
					var td1 = "";
					var td2 = "";
					var td3 = "";
					var td4 = "";
					var labelName1 = "";
					var labelValue1 = "";
					var labelName2 = "";
					var labelValue2 = "";
					
					agentName = document.getElementById("agentNamedata").value;
					agentID = agentName;
					//closeWindow();
					var tempCustomerID = 0;
					var batchID = 0;
					if(CustomerDetails != null && CustomerDetails != "" && typeof CustomerDetails !== "undefined") {
						tempCustomerID = CustomerDetails["CUSTOMERID"];
						batchID = CustomerDetails["BATCHID"];
					}
					
					var processxmlData = "<ROOT><PROCESS><FLDCUSTOMERID>" + tempCustomerID +"</FLDCUSTOMERID>";
					var tableRow = $("#processTable").find("tr");
					var processLength = tableRow.length;
					for(var i = 0; i < processLength; i++) {
						td1 = tableRow.eq(i).find('td:eq(0)');
						td2 = tableRow.eq(i).find('td:eq(1)');
						td3 = tableRow.eq(i).find('td:eq(2)');
						td4 = tableRow.eq(i).find('td:eq(3)');
						
						if(td1 != null && td1 != "" && typeof td1 !== "undefined") {
							if(td1.find("label").attr("id") != null && typeof td1.find("label").attr("id") !== "undefined" && td1.find("label").attr("id") != "")
								labelName1 = td1.find("label").attr("id");
						}
						if(td2 != null && td2 != "" && typeof td2 !== "undefined") {
							if(td2.find("input").val() != null && typeof td2.find("input").val() !== "undefined" && td2.find("input").val() != "") {
								labelValue1 = td2.find("input").val();
							} else if(td2.find("textarea").val() != null && typeof td2.find("textarea").val() !== "undefined" && td2.find("textarea").val() != "") {
								labelValue1 = td2.find("textarea").val();
							} else if(td2.find("select").val() != null && typeof td2.find("select").val() !== "undefined" && td2.find("select").val() != "") {
								labelValue1 = td2.find("select").val();
							}
						}
						
						if(td3 != null && td3 != "" && typeof td3 !== "undefined") {
							if(td3.find("label").attr("id") != null && typeof td3.find("label").attr("id") !== "undefined" && td3.find("label").attr("id") != "")
								labelName2 = td3.find("label").attr("id");
						}
						if(td4 != null && td4 != "" && typeof td4 != "undefined") {
							if(td4.find("input").val() != null && typeof td4.find("input").val() !== "undefined" && td4.find("input").val() != "") {
								labelValue2 = td4.find("input").val();
							} else if(td4.find("textarea").val() != null && typeof td4.find("textarea").val() !== "undefined" && td4.find("textarea").val() != "") {
								labelValue2 = td4.find("textarea").val();
							} else if(td4.find("select").val() != null && typeof td4.find("select").val() !== "undefined" && td4.find("select").val() != "") {
								labelValue2 = td4.find("select").val();
							}
						}
						// MTK
						if((labelName1 != "" && labelValue1 != "") && (typeof labelName1 !== "undefined" && typeof labelValue1 !== "undefined") && (labelName1 != null && labelValue1 != null)) {
							processxmlData += "<" + labelName1 + "><![CDATA[" + replaceChars(labelValue1) + "]]></" + labelName1 + ">";
							//alert("labelName1m"+labelName1+"labelValue1m="+labelValue1);
							if(labelName1=="FLDFILLER3"){
								var PTPAmount=labelValue1;
								//alert("Amount="+PTPAmount);
							}
							labelName1 = "";
							labelValue1 = "";
						}
						if((labelName2 != "" && labelValue2 != "") && (typeof labelName2 !== "undefined" && typeof labelValue2 !== "undefined") && (labelName2 != null && labelValue2 != null)) {
							processxmlData += "<" + labelName2 + "><![CDATA[" + replaceChars(labelValue2) + "]]></" + labelName2 + ">";
							//alert("labelName2m"+labelName2+"labelValue2m="+labelValue2);
							if(labelName2=="FLDFILLER2"){
								var PTPdate=labelValue2;
							//	alert("Date="+PTPdate);
							}
							labelName2 = "";
							labelValue2 = "";
						}
					}
					processxmlData += "</PROCESS>";
					processxmlData += "</ROOT>";
					
					if(jsonCallDispParse != null && jsonCallDispParse != "" && typeof jsonCallDispParse !== "undefined") {
						if(jsonCallDispParse["dialNumber"] != "" && jsonCallDispParse["dialNumber"] != null && typeof jsonCallDispParse["dialNumber"] !== "undefined") {
							dialNumber = jsonCallDispParse["dialNumber"];
						}
						if(jsonCallDispParse["idleTime"] != "" && jsonCallDispParse["idleTime"] != null && typeof jsonCallDispParse["idleTime"] !== "undefined") {
							idleTime = jsonCallDispParse["idleTime"];
						}
						if(jsonCallDispParse["talkTime"] != "" && jsonCallDispParse["talkTime"] != null && typeof jsonCallDispParse["talkTime"] !== "undefined") {
							talkTime = jsonCallDispParse["talkTime"];
						}
						if(jsonCallDispParse["wrapTime"] != "" && jsonCallDispParse["wrapTime"] != null && typeof jsonCallDispParse["wrapTime"] !== "undefined") {
							wrapTime = jsonCallDispParse["wrapTime"];
						}
						if(jsonCallDispParse["holdTime"] != "" && jsonCallDispParse["holdTime"] != null && typeof jsonCallDispParse["holdTime"] !== "undefined") {
							holdTime = jsonCallDispParse["holdTime"];
						}
						if(jsonCallDispParse["previewTime"] != "" && jsonCallDispParse["previewTime"] != null && typeof jsonCallDispParse["previewTime"] !== "undefined") {
							previewTime = jsonCallDispParse["previewTime"];
						}
						if(jsonCallDispParse["callStartTime"] != "" && jsonCallDispParse["callStartTime"] != null && typeof jsonCallDispParse["callStartTime"] !== "undefined") {
							callStartTime = jsonCallDispParse["callStartTime"];
						}
						if(jsonCallDispParse["callEndTime"] != "" && jsonCallDispParse["callEndTime"] != null && typeof jsonCallDispParse["callEndTime"] !== "undefined") {
							callEndTime = jsonCallDispParse["callEndTime"];
						}
						// Added on 24-03-2017 LCS
						if(jsonCallDispParse["lcsTokenNo"] != "" && jsonCallDispParse["lcsTokenNo"] != null && typeof jsonCallDispParse["lcsTokenNo"] !== "undefined") {
							lcsTokenNo = jsonCallDispParse["lcsTokenNo"];
						}
						// Ended
						if(jsonCallDispParse["sequenceNumber"] != "" && jsonCallDispParse["sequenceNumber"] != null && typeof jsonCallDispParse["sequenceNumber"] !== "undefined") {
							recordingSeq = jsonCallDispParse["sequenceNumber"];
						} else {
							recordingSeq = sequenceNumber;
						}
					}
			
					var date1=$("#callbackdatetimepicker").val();
					 if(talk_dur=="NaN"){
							talk_dur = 0;
						 }else{
							 
						 }
					callDetailsXmlData += "<ROOT><CALLDETAILS>" +
					"<FLDCUSTOMERID>" + tempCustomerID + "</FLDCUSTOMERID>" +
					"<FLDBATCHID>" + batchID + "</FLDBATCHID>" +
					"<FLDAGENTNAME>" + agentName + "</FLDAGENTNAME>" +
					"<FLDAGENTID>" + agentID + "</FLDAGENTID>" +
					"<FLDCALLID>" + callID + "</FLDCALLID>" +
					"<FLDDIALLEDNUMBER>" + dail_no + "</FLDDIALLEDNUMBER>" +
					"<FLDIDLETIME>" + idleTime + "</FLDIDLETIME>" +
					"<FLDTALKTIME>" + talk_dur + "</FLDTALKTIME>" +
					"<FLDWRAPTIME>" + wrap_dur + "</FLDWRAPTIME>" +
					"<FLDHOLDTIME>" + hold_dur + "</FLDHOLDTIME>" +
					"<FLDPREVIEWTIME>" + previewTime + "</FLDPREVIEWTIME>" +
					 "<FLDCALLSTARTTIME>" + call_start + "</FLDCALLSTARTTIME>" + //2021-05-19 16:13:41  "<FLDCALLSTARTTIME>" + callStartTime + "</FLDCALLSTARTTIME>" +
					 "<FLDCALLENDTIME>" + call_end + "</FLDCALLENDTIME>" + //"<FLDCALLENDTIME>" + callEndTime + "</FLDCALLENDTIME>" +
					"<FLDPROCESSID>" + processID + "</FLDPROCESSID>" +
					"<FLDSUBPROCESSID>" + subProcessID + "</FLDSUBPROCESSID>" +
					"<FLDAGENTREMARKS><![CDATA[" + replaceChars(agentRemarks) +"]]></FLDAGENTREMARKS>" +
					 "<FLDDISPOSITIONID>" + dispositionID + "</FLDDISPOSITIONID>" +
					 "<FLDDISPOSITIONCODE>" + dispositionCode + "</FLDDISPOSITIONCODE>" + //"<FLDDISPOSITIONID>11</FLDDISPOSITIONID>" + "<FLDDISPOSITIONCODE>CDTC</FLDDISPOSITIONCODE>" +
					"<FLDDISPOSITION>" + disposition + "</FLDDISPOSITION>" +
					"<FLDSUBDISPOSITION>" + subDisposition + "</FLDSUBDISPOSITION>" +
					"<FLDSUBDISPOSITIONCODE>" + subDispositionCode + "</FLDSUBDISPOSITIONCODE>" +
					"<DISPCALLBACKFLAG>" + callbackFlag + "</DISPCALLBACKFLAG>" +
					"<FLDCALLBACKNUMBER>" + callBackNumber + "</FLDCALLBACKNUMBER>" +
					"<FLDCALLBACKTYPE>" + callBackType + "</FLDCALLBACKTYPE>" +
					"<FLDCALLBACKDATE>" + date1 + "</FLDCALLBACKDATE>" +
					"<FLDLANGUAGE>" + language + "</FLDLANGUAGE>" +
					"<FLDDATE>" + date + "</FLDDATE>" +
					"<FLDSERVICEID>" + serviceID + "</FLDSERVICEID>" +
					"<FLDSERVICENAME>" + serviceName + "</FLDSERVICENAME>" +
					"<FLDCALLTABLE>" + tableName + "</FLDCALLTABLE>" +
					"<FLDAGENTINDEX>" + agentIndex + "</FLDAGENTINDEX>" +
					"<FLDAUTORECORDING>" + autoRecording + "</FLDAUTORECORDING>" +
					"<FLDFILENAME>" + fileName + "</FLDFILENAME>" +
					"<FLDMEDIATYPE>" + mediaType + "</FLDMEDIATYPE>" +
					"<FLDRECINDEX>" + recordingIndex + "</FLDRECINDEX>" +
					"<FLDRECRATE>" + recordingRate + "</FLDRECRATE>" +
					"<FLDRECSEQ>" + recordingSeq + "</FLDRECSEQ>" +
					"<FLDRECSTATE>" + recordingState + "</FLDRECSTATE>" +
					"<FLDRECSTOREID>" + recordingStoreID + "</FLDRECSTOREID>" +
					"<FLDLCSTOKENNO>" + lcsTokenNo + "</FLDLCSTOKENNO>" + // Added on 24-03-2017 LCS
					"</CALLDETAILS></ROOT>";
					
					// Added on 11-07-0217
					var jsDate = new Date();
			    	var jsLogDateTime = (jsDate.getDate() < 10 ? "0" + jsDate.getDate() : jsDate.getDate())  + "-" + ((jsDate.getMonth()) < 10 ? "0" + (jsDate.getMonth() + 1) : jsDate.getMonth() + 1) + "-" + jsDate.getFullYear() + " " + jsDate.getHours() + ":" + jsDate.getMinutes() + ":" + (jsDate.getSeconds() < 10 ? "0" + jsDate.getSeconds() : jsDate.getSeconds());
			    //	writeFile.WriteLine(jsLogDateTime + " : Process Xml Data : " + processxmlData);
			    //	writeFile.WriteLine(jsLogDateTime + " : CallDetails Xml Data : " + callDetailsXmlData);
					// Ended
					
					var data = "opcode=customerupdate&processXml=" + processxmlData + "&callDetailsXml=" + callDetailsXmlData;
			//	 console.log("*********data**********"+data);
				stringdisp = JSON.stringify(dispositons);
				    $.ajax({
				        type: "POST",
				        url: "portal",
				        data: data,
				        dataType: 'json',
				        async: false,
				        success: function(response) {
							
				        	var jsDate = new Date();
			    			var jsLogDateTime = (jsDate.getDate() < 10 ? "0" + jsDate.getDate() : jsDate.getDate())  + "-" + ((jsDate.getMonth()) < 10 ? "0" + (jsDate.getMonth() + 1) : jsDate.getMonth() + 1) + "-" + jsDate.getFullYear() + " " + jsDate.getHours() + ":" + jsDate.getMinutes() + ":" + (jsDate.getSeconds() < 10 ? "0" + jsDate.getSeconds() : jsDate.getSeconds());
				        	//writeFile.WriteLine(jsLogDateTime + " : appletdispose Success : " + JSON.stringify(response));
				        	// Ended		        	
				        	stopDisposeTimer();
				        	responseJSON = JSON.parse(JSON.stringify(response));
				        	statsDetails = responseJSON["AgentStatsDetails"];
				        	isActive = false;
				        	if(statsDetails["updateStatus"] == "Success" && statsDetails != null) {
					        	$("#leads").val(statsDetails["LEADS"] != "" ? statsDetails["LEADS"] : 0);
					        	$("#notcontact").val(statsDetails["NOTCONTACT"] != "" ? statsDetails["NOTCONTACT"] : 0);
								$("#rpc").val(statsDetails["RIGHTPARTYCONTACT"] != "" ? statsDetails["RIGHTPARTYCONTACT"] : 0);
								$("#cd").val(statsDetails["CALLDISCONNECT"] != "" ? statsDetails["CALLDISCONNECT"] : 0);
								$("#cb").val(statsDetails["CALLBACK"] != "" ? statsDetails["CALLBACK"] : 0);
								$("#tpc").val(statsDetails["THIRDPARTYCONTACT"] != "" ? statsDetails["THIRDPARTYCONTACT"] : 0);
								$("#successful").val(statsDetails["SUCCESSFULL"] != "" ? statsDetails["SUCCESSFULL"] : 0);
								$("#leadCallBack").val(statsDetails["LEADCALLBACK"] != "" ? statsDetails["LEADCALLBACK"] : 0);
								$("#autoWrap").val(statsDetails["AUTOWRAP"] != "" ? statsDetails["AUTOWRAP"] : 0);
								$("#totalcalls").val(statsDetails["TOTALCALLS"] != "" ? statsDetails["TOTALCALLS"] : 0);
								$("#loginHours").val(statsDetails["LOGINHOURS"] != "" ? statsDetails["LOGINHOURS"] : "00:00:00");
								$("#auxtime").val(statsDetails["AUXTIME"] != "" ? statsDetails["AUXTIME"] : "00:00:00");
								$("#lunch").val(statsDetails["LUNCH"] != "" ? statsDetails["LUNCH"] : "00:00:00");
								$("#teabreak").val(statsDetails["TEABREAK"] != "" ? statsDetails["TEABREAK"] : "00:00:00");
								$("#personalBreak").val(statsDetails["PERSONAL"] != "" ? statsDetails["PERSONAL"] : "00:00:00");
								$("#productiveTime").val(statsDetails["PRODUCTIVETIME"] != "" ? statsDetails["PRODUCTIVETIME"] : "00:00:00");
								$("#others").val(statsDetails["OTHERS"] != "" ? statsDetails["OTHERS"] : "00:00:00"); 
								
								$("#customerTable").html("");
				        		$("#customerTable").show();
				        	/* 	$("#customerTable").append('<div style="height: 387px; line-height: 350px;">' + 
					    		'<h1 id="customerBody" style="color: green; text-align: center; font-size: 50px;">Waiting For Call</h1>' +
					    		'</div>'); */
				        		$("#navigationtabs").html("");
				        		$("#navigationtabs").hide();
				        		$("#processTable").hide();
				        		$("#processTable").html("");
				        		$("#historyshowdata").html("");
				        		$("#historydata").hide();
				        		// Added on 16-11-2017
				        		$("#bottomdiv").show();
				        		$("#agentscriptslinks").hide();
				        		// Added on 24-03-2017 LCS
				        		$("#lcstabdata").html();
				        		$("#lcstabdata").hide();
				        		// Ended
				        		
				        		$("#agentRemarks").val("");
				        		$("#callBackNumber").val("");
				        		$("#disposition").html("");
				        		// Added on 16-11-2017
				        		//$("#disposition").append('<option id="159" data="THPY" value="Third Party">Third Party</option>');
								$("#subDisposition").html("");
								$("#callBackType").html("");
								$("#callbackdatetimepicker").val("");
								$('#bottomdiv input[type="radio"]').each(function () { 
									 $(this).prop('checked', false); 
								});
							//	$("#language").html("");
				        		
				        		CustomerDetails = "";
								LOBDetails = "";
								AgentScriptDetails = "";
								labelMapDetails = "";
								orderMapDetails = "";
								subProcessDetails = "";
								processDetails = "";
								// Added on 24-03-2017 LCS
								lcsDetails = "";
								
				        	} else {
				        		stopDisposeTimer();
				        		$("#customerTable").html("");
				        		$("#customerTable").show();
				        		$("#customerTable").append('<div style="height: 387px; line-height: 350px;">' + 
					    		'<h1 id="customerBody" style="color: green; text-align: center; font-size: 50px;">Waiting For Call</h1>' +
					    		'<h2 style="color :red; text-align: center; margin-top:-335px">---DATA--</h2>' +
					    		'</div>');
				        		$("#navigationtabs").html("");
				        		$("#navigationtabs").hide();
				        		$("#processTable").hide();
				        		$("#historyshowdata").html("");
				        		$("#historydata").hide();
				        		$("#agentscriptslinks").hide();
				        		// Added on 16-11-2017
				        		$("#bottomdiv").show();
				        		// Added on 24-03-2017 LCS
				        		$("#lcstabdata").html();
				        		$("#lcstabdata").hide();
				        		// Ended
				        		
				        		$("#agentRemarks").val("");
				        		$("#callBackNumber").val("");
				        		$("#disposition").html("");
				        		// Added on 16-11-2017
				        		//$("#disposition").append('<option id="159" data="THPY" value="Third Party">Third Party</option>');
								$("#subDisposition").html("");
								$("#callBackType").html("");
								$("#callbackdatetimepicker").val("");
								$('#bottomdiv input[type="radio"]').each(function () { 
									 $(this).prop('checked', false); 
								});
							//	$("#language").html("");
				        		
				        		CustomerDetails = "";
								LOBDetails = "";
								AgentScriptDetails = "";
								labelMapDetails = "";
								orderMapDetails = "";
								subProcessDetails = "";
								processDetails = "";
								// Added on 24-03-2017 LCS
								lcsDetails = "";
				        	} 
				        },
				        error: function(xhr, status, error) {
				        	// Added on 11-07-0217
				        	var jsDate = new Date();
			    			var jsLogDateTime = (jsDate.getDate() < 10 ? "0" + jsDate.getDate() : jsDate.getDate())  + "-" + ((jsDate.getMonth()) < 10 ? "0" + (jsDate.getMonth() + 1) : jsDate.getMonth() + 1) + "-" + jsDate.getFullYear() + " " + jsDate.getHours() + ":" + jsDate.getMinutes() + ":" + (jsDate.getSeconds() < 10 ? "0" + jsDate.getSeconds() : jsDate.getSeconds());
						 
				        }
					});
			      } else {
			    	  dispositons = {"disposeStatus" : flag};
			    	  stringdisp = JSON.stringify(dispositons);
			      }
			      return stringdisp;
				}
			
				 window.addEventListener('beforeunload', function (e) {
					 
					  authdata="";
					  sessiondata="";
					 $.ajax({
				            url: main_url+'Logout',
				            type: 'POST',
				 			data: {place:place},
				            success: function(data){
							
									var boolValue = JSON.parse(data);
									
										if(boolValue){
									 
										clearInterval(interval);
										clearInterval(myVar);
										  $("#divlogoDisplay").show();
										  $("#divappletlogin").show();
										  $("#divappletbody").hide();
										  $("#divheadertable").hide();
										  deleteAllCookies();
										  window.location.reload(true);
										 	 $('#login').prop("disabled", false);
											$('input[type="text"]').css({"border":"1px solid grey","box-shadow":"0 0 5px grey"});
											$('input[type="password"]').css({"border":"1px solid grey","box-shadow":"0 0 5px grey"});
										  
										}
										
								 
							 },
				            error:function(error){
				                console.log('Ajax request error : ' + error);
				            }
				         });
								
					 e.preventDefault();
			            e.returnValue = '';	
							});
	
				 function yono_window(){
					  showWindow($.trim(yonowindow));
						isWindowOpen=true;
				}
				 
				 function copynumber(){

					 var number=document.getElementById("mobileNumber99").value;
					 navigator.clipboard.writeText(number);
				 }
				 
			function SaveIVR(){
			
				var Papldatetime=document.getElementById("Papldatetime").value;
				var LoanTenure=document.getElementById("LoanTenure").value;
				var LoanAmount=document.getElementById("LoanAmount").value;
				
				alert("Papldatetime-"+Papldatetime+"="+"LoanTenure="+LoanTenure+"LoanAmount="+LoanAmount);
			
				 	
			}
	</script>
	 
	</head>
	<body>
	  
	<div id="divlogoDisplay" style="">
	
	 <table style="width:100%">
  <tr>
    <th style="text-align:left"><img src="images/intelenet.JPG"/></th>
    <th style="text-align:center"><h1 style="color:#FFFFFF;">SBI DEMS OB Agent Portal<h1></th> 
    <th style="text-align:right"><img src="images/sbi.png" style="height: 81px;"/></th>
  </tr>
  <tr>
    <td style="text-align:left"></td>
    <td style="text-align:center"><h2 style="color:#FFFFFF;">APM ID: APP04829<h2></td>  <!-- 504 -->
    <td style="text-align:right"></td>
  </tr>
   <input type="hidden" id="myNumber" name="myNumber" value="">
   <input type="hidden" id="skey" name="skey" value="">
   <input type="hidden" id="skey" name="username_data" value="">
   <input type="hidden" id="skey" name="password_data" value="">
   <input type="hidden" id="count" name="count" value="">
</table>
		      
	</div>
	
	
		<div id="divappletlogin" style="text-align: center; margin-top:2px;">
			<section class="container">
			 <div class="login" style="background-color: #97B9D4">
			
			<!-- <jsp:plugin code="com.smartnapp.smartportal.applet.LoginApplet.class" codebase="." 
				      archive="capp.jar,swingx-all-1.6.4.jar"
				      type="applet" width="80%" height="220">
		     </jsp:plugin> --> 
		     <div class= "main" width="80%" height="220" style="float: revert;border: none;">
		     <form class="form" method="post" action="#">
		     <div><input type="text" class="txtbox" name="demail" id="email" placeholder="Username" autocomplete="off"></div>
		     <div><input type="password" class="txtbox" name="password" id="password" placeholder="Password" autocomplete="off"></div>
		     <div><input type="text" class="txtbox" name="place" id="place" maxLength="25" placeholder="Place" autocomplete="off"></div>
		     <br>
		     <br>
			<div><input type="button" name="login" id="login" value="Login"></div>
		     </form>
		     </div>
		     </div>
		     </section>
    	</div>
    	
    <%-- 	<jsp:include page="agentHeader.jsp" />  --%>
    	
    	<div id="divappletbody" style="display : none;">
		
	   	<div id="getnextinfo">
		   	<span id="autodisposespan" style="border: 2px solid #a1a1a1; border-radius: 5px; float: right; margin-top: 0px; padding: 0px 0px; display: none;">
		   	<span id="disposeTime" style="float: right;">0</span>
		   	<span id="autodispaoselabel" style="float: right;">Auto Dispose :</span></span>
	   	</div>
	   	
	    <div id="navigationtabs" style="margin-top: 10px;"></div>
	    
	    <div id="customerTable" style="margin-top: 4px; margin-bottom: 4px;">
	    	<div style="height: 468px; line-height: 350px;">
	    		<h1 id="customerBody" style="color: orange; text-align: center; font-size: 50px;">Click Ready</h1>
	    	</div>
	    </div>
	    
	    <div id="processTable" style="display: none; margin-top: 4px;"></div>
	    
	    <div id="historydata" style="display: none; margin-top: 4px;">
		    <label style="margin-right: 50px;">Phone Number<span style='color:red;'>*</span></label>
		    <input type="text" id="phonenumber" name="phonenumber" placeholder="Phone Number" value="" maxlength="10">
		    <button id="buttonhistorysearch" style="margin-left: 10px; cursor: pointer;">Search</button>
		       <button id="copynumber99" style="margin-left: 10px; cursor: pointer; display: none;" onclick="copynumber()">Copy</button>
		         <input type="text" id="mobileNumber99" name="mobileNumber99" style="display: none">
			<div id="historyshowdata" style="margin-top: 8px;"></div>
	    </div>
	    
	    <div id="agentscriptslinks" style="margin: 4px; display: none;"></div>
	   <input style="display: none;" type="text" id="subprocess_data" readonly name="subprocess_data"  >
	    <input style="display: none;" type="text" id="number_data" readonly name="number_data"  >
	     
	    
	     <input style="display: none;" type="text" id="p2pdate" readonly name="p2pdate"  >
	      <input style="display: none;" type="text" id="p2pamount" readonly name="p2pamount"  >
	       <input style="display: none;" type="text" id="fld4" readonly name="fld4"  >
		<div id="agentstatsinfo">
		<input type="button" style="display:none;" id="yonowindow" name="yonowindow" value="Yonowindow"  onClick="yono_window()" />
		<table>
		<!-- <tr><td></td>
		        <td><input type="button" onlclick="getAgentStatusdata()" value="RefreshData" ></td></tr> -->
		      	<tr><td>Agent Name</td>
		        <td><input type="text" id="agentNamedata" readonly name="agentName"  ></td></tr>
		        <tr><td>Login Hours</td>
		        <td><input type="text" id="loginHours1" readonly  ></td></tr>
		         <tr><td>IdleTime</td>
		        <td><input type="text" id="ReadyDuration1" readonly name="ReadyDuration1" ></td></tr>
		        <tr><td>NotReady</td>
		        <td><input type="text" id="NotReadyDuration1" readonly name="NotReadyDuration1"  ></td></tr>
		        <tr><td>TalkDuration</td>
		        <td><input type="text" id="TalkDuration1" readonly name="TalkDuration1" ></td></tr>
		        <tr><td>HoldDuration</td>
		        <td><input type="text" id="HoldDuration33" readonly name="HoldDuration3" ></td></tr>
		        <tr><td>WrapDuration</td>
		        <td><input type="text" id="WrapDuration33" readonly name="WrapDuration3" ></td></tr>
		        <tr ><td>Total calls</td>
		        <td><input type="text" id="OutboundCalls1" readonly name="OutboundCalls1" ></td></tr>
		        <tr  ><td>Successful Call</td>
		        <td><input type="text" id="successfuldata" readonly name="successfuldata" value="0"></td></tr>
		        <tr  ><td>Right Party Call</td>
		        <td><input type="text" id="rightpartydata" name="auxtime"  readonly value="0"></td></tr>
		         <tr  ><td>Third Party Call</td>
		        <td><input type="text" id="thirdpatydata" readonly name="thirdpatydata" value="0"></td></tr>
		       
		        <tr  ><td>Call Back</td>
		        <td><input type="text" id="CallbackAgent" readonly name="CallbackAgent" value=""></td></tr>
		         
		        <tr ><td>Productive Time</td>
		        <td><input type="text" id="productiveTime999" readonly name="productiveTime999" value=""></td></tr>
		        
		        <tr  ><td>Lunch</td>
		        <td><input type="text" id="lunchTime99" readonly name="lunch" value=""></td></tr>
		        
		        <tr ><td>Others</td>
		        <td><input type="text" id="others" readonly name="others" value="0"></td></tr>
		        
		    </table>
		    
		    <!--  Not use below table code -->
		    
	   	<table style="display: none;">
		      	<tr><td>Agent Name</td>
		        <td><input type="text" id="agentName" readonly name="agentName" value="TEST"></td></tr>
		        <tr><td>Leads</td>
		        <td><input type="text" id="leads" readonly name="leads" value="0"></td></tr>
		        <tr><td>Not Contact</td>
		        <td><input type="text" id="notcontact" readonly name="notcontact" value="0"></td></tr>
		        <tr><td>Right Party Contact</td>
		        <td><input type="text" id="rpc" readonly name="rpc" value="0"></td></tr>
		        <tr><td>Call Disconnect</td>
		        <td><input type="text" id="cd" readonly name="cd" value="0"></td></tr>
		        <tr><td>Call Back</td>
		        <td><input type="text" id="cb" readonly name="cb" value="0"></td></tr>
		        <tr><td>Third Party Contact</td>
		        <td><input type="text" id="tpc" readonly name="tpc" value="0"></td></tr>
		        <tr><td>Successful</td>
		        <td><input type="text" id="successful" readonly name="successful" value="0"></td></tr>
		        <tr><td>Lead Call Back</td>
		        <td><input type="text" id="leadCallBack" readonly name="leadCallBack" value="0"></td></tr>
		        <tr><td>Auto Wrap</td>
		        <td><input type="text" id="autoWrap" readonly name="autoWrap" value="0"></td></tr>
		        <tr><td>Total Calls</td>
		        <td><input type="text" id="totalcalls" readonly name="totalcalls" value="0"></td></tr>
		        <tr><td>Productive Time</td>
		        <td><input type="text" id="productiveTime" readonly name="productiveTime" value="00:00:00"></td></tr>
		        <tr><td>Aux Time</td>
		        <td><input type="text" id="auxtime" name="auxtime"  readonly value="00:00:00"></td></tr>
		        <tr><td>Lunch</td>
		        <td><input type="text" id="lunch" readonly name="lunch" value="00:00:00"></td></tr>
		        <tr><td>Tea Break</td>
		        <td><input type="text" id="teabreak" readonly name="teabreak" value="00:00:00"></td></tr>
		        <tr><td>Personal Break</td>
		        <td><input type="text" id="personalBreak" readonly name="personalBreak" value="00:00:00"></td></tr>
		        <tr><td>Others</td>
		        <td><input type="text" id="others" readonly name="others" value="0"></td></tr>
		        <tr><td>Login Hours</td>
		        <td><input type="text" id="loginHours" readonly name="loginHours" value="00:00:00"></td></tr>
		    </table>
	   	</div>
	   	
	   	<!-- Added on 24-03-2017 LCS -->
	   	<div id="lcstabdata" style="display: none; margin: 4px; background-color: white; height:454px; border: 2px solid #a1a1a1; border-radius : 5px;">
		</div>
		 
		</div>
		
		<div id="loginFooter">
 
</div>

 
	</body>
	
</html>