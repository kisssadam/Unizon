// leanModal v1.1 by Ray Stone - http://finelysliced.com.au
// Dual licensed under the MIT and GPL

$(function(){

(function($) {
	$.fn.extend({
		leanModalLoad : function(options) {
			var defaults = {
				top : 100,
				overlay : 0.5,
				closeButton : null,
				href:null
			};
			var overlay = $("<div id='lean_overlay'></div>");
			$("body").append(overlay);
			options = $.extend(defaults, options);
			return this.each(function() {
				var o = options;
				$(this).click(function(e) {
					if (o.href == null){
						var modal_id=$(this).attr("href");
					}else{
						var modal_id=o.href;
					}					
					console.log(modal_id);	
					$("#lean_overlay").click(function() {
						close_modal_alt(modal_id)
					});
					$(o.closeButton).click(function() {
						close_modal_alt(modal_id)
					});
					var modal_height = $(modal_id).outerHeight();
					var modal_width = $(modal_id).outerWidth();
					$("#lean_overlay").css({
						"display" : "block",
						opacity : 0
					});
					$("#lean_overlay").fadeTo(150, o.overlay);
					$(modal_id).css({
						"display" : "block",
						"box-sizing": "border-box",
				        "border-radius": "3px",
						"position" : "fixed",
						"opacity" : 0,
						"z-index" : 11000,
						"left" : 50 + "%",
						"margin-left" : -(modal_width / 2) + "px",
						"top" : o.top + "px"
					});
					$(modal_id).fadeTo(150, 1);
					e.preventDefault()
				})
			});
			function close_modal_alt(modal_id) {
				$("#lean_overlay").fadeOut(150);
				$(modal_id).css({
					"display" : "none"
				});
				
			}
		}
	})
})(jQuery);

$(".modal_trigger_alt").leanModalLoad({top: 120, overlay: 0.6, closeButton: ".modal_close", href:"#modal_edit_address"});

});
