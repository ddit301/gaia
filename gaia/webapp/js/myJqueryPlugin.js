$.test=function(){
	alert("TEST");
}
$.fn.test2 = function(){
	alert("TEST2" + this.attr("method"));
};
$.fn.formToAjax = function(param){
	
	 	this.on("submit", function(event){
 		event.preventDefault();
 		let url = this.action;
 		let method = this.method;
 		let inputs = $(this).find(":input")
 		let data = {};
 		$(inputs).each(function(index, input){
 			let name = $(this).attr("name");
 			let value = $(this).val();
 			data[name] = value;
 		});
		
 		$.ajax({
 			url : url,
 			method : method,
 			data : data,
 			dataType : param.dataType,
 			success : param.success,
 			error : function(xhr, error, msg) {
 				console.log(xhr);
 				console.log(error);
 				console.log(msg);
 			}
 		})
 	})
	return this;
	
}