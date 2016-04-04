$(document).ready(function(){

	$('.additional-questions > a').click(function(){
		$(this).parent().addClass('show-form');
		return false;
	});

	$('.type-of-care input[type=checkbox]').change(function(){
		if($(this).is(':checked')) {
			$(this).closest('.group').addClass('checked');
		} else {
			$(this).closest('.group').removeClass('checked');
		}
	});
});