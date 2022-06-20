function optionChange() {
	var arr1_select = ['110 - 서울', '120 - 인천', '130 - 부산'];
	var arr1_value = ['110', '120', '130'];
	
	var arr2_select = ['210 - 서울', '220 - 인천', '230 - 부산'];
	var arr2_value = ['210', '220', '230'];
	
	var arr3_select = ['310 - 서울', '320 - 인천', '330 - 부산'];
	var arr3_value = ['310', '320', '330'];

	var arr4_select = ['410 - 서울', '420 - 인천', '430 - 부산'];
	var arr4_value = ['410', '420', '430'];
		
	var select_value = $("#code1").val();
	var txt_option;
	var option_value;
	
	if(select_value == '100') {
		txt_option = arr1_select;
		option_value = arr1_value;
	} else if(select_value == '200') {
		txt_option = arr2_select;
		option_value = arr2_value;
	} else if(select_value == '300'){
		txt_option = arr3_select;
		option_value = arr3_value;
	} else {
		txt_option = arr4_select;
		option_value = arr4_value;
	}
	$("#code2").empty();
	for(var i = 0; i < txt_option.length; i++) {
		$("#code2").append('<option value=' + option_value[i]+ '>' + txt_option[i] + '</option>');
	}
}