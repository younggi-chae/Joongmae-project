
//견적서 선택하기
var list = new Array();

      function checkFunction(input, sellNo) {
        if (input.checked == true) {
           list.push(sellNo);
           //alert(list);
        } else {
           var index = list.indexOf(sellNo);
           if (index > -1) {
              list.splice(index, 1);
              //alert(list);
           }
        }
     }//end checkFunction

$(document).ready(function(){
	
	//sellList Modal 창 코드
	$("#sendSellView").on("click", function(e){
		e.preventDefault();
		
		$("#myModal").modal("show");
		
		//sellList 처음에 3개만 보이기
		$("#modalTable tbody tr").slice(3).hide();
		
	});//end #sendSell
	
	//sellList Modal 창 더보기 코드
	$("#load").click(function(e){ // click event for load more
        e.preventDefault();
        $("#modalTable tbody tr:hidden").slice(0, 2).show(); // select next 10 hidden divs and show them
        if($("#modalTable tbody tr:hidden").length == 0){ // check if any hidden divs still exist
            alert("마지막 견적서 입니다."); // alert if there are none left
            $("#load").hide();
        }
    });
	
	
	//sellDetail Modal 코드
	$(".detailSell").on("click", function(e){
		e.preventDefault();
		$("#secondModal").modal("show");
		
		var sellNo = $(this).parent().prev().text();
		
		$.ajax({
			
			url : "/buyBoard/sellDetail/" + sellNo,
			data : sellNo,
			type : "GET",
			success : function(sellDetail){
				
				$("#detailForm").find("input[name='itemName']").val(sellDetail.itemName);
				$("#detailForm").find("input[name='bigClassifier']").val(sellDetail.bigClassifier);
				$("#detailForm").find("input[name='mediumClassifier']").val(sellDetail.mediumClassifier);
				$("#detailForm").find("input[name='keyword']").val(sellDetail.keyword1 + "/" + sellDetail.keyword2 +
						"/" + sellDetail.keyword3);
				$("#detailForm").find("input[name='type']").val(sellDetail.type);
				$("#detailForm").find("input[name='region']").val(sellDetail.region);
				$("#detailForm").find("input[name='itemCondition']").val(sellDetail.itemCondition);
				$("#detailForm").find("input[name='price']").val(sellDetail.price);
				$("#detailForm").find("input[name='regDate']").val(sellDetail.regDate);
				
			}//end success
			
		});//end ajax
		
	});//end detailSell
	
	
	
	//견적서 보내기 코드
	$("#sendSell").on("click", function(){
		
		var buyNo = $("#sellBody").find("input[name='buyNo']").val();
		var buyId = $("#sellBody").find("input[name='buyId']").val();
		var sellId = $("#sellBody").find("input[name='sellId']").val();
		
		$.ajax({
			
			url : "/buyBoard/registerAlarm/" + buyNo + "/" + buyId + "/" + sellId + "/" + list,
			type : "GET",	
			success : function(result){
				alert("견적서를 보냈습니다.");
				
				$("input[type=checkbox]:checked").each(function(){
					$(this).prop("checked", false);
				});
				
				$("#myModal").modal("hide");
				
			}
			
			
			
		});//end ajax
		
	});//end #sendSell
	
	
});













