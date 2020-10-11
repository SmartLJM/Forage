$(function () {

	function ScrollHead($element){
			this.$barconatiner = $element;
			this.barheight = $element.height();
			this.topOffSet = $element.offset().top;
// 占位块，使得过渡自然
			this.stickyDiv = '<div class="sticky-placeholder" style="height:' + this.barheight + 'px"></div>';

			this.init();
	}

	ScrollHead.prototype = {
		init:function(){

// console.log(this.$barconatiner);

			if (this.$barconatiner.is('*')) {
		// 发生滚动事件
				var topbar = this.$barconatiner;
				var occurheight = this.barheight + this.topOffSet;
				var _this = this;
		    $(window).scroll(function (event) {
		      // 滚动的距离 this 指 window
		      var y = $(this).scrollTop();
		      // console.log($(this));
		      // 距离出发条件
		      // console.log(y + ":" + occurheight);
		      if (y >= occurheight) {
		        if (topbar.hasClass('fixed')) {
		          // 对应bootstrap中的固定
		        } else {
		          // position:sticky是一个新的css3属性，它的表现类似position:relative和position:fixed的合体，
		          // 在目标区域在屏幕中可见时，它的行为就像position:relative; 
		          // 而当页面滚动超出目标区域时，它的表现就像position:fixed，它会固定在目标位置。
		          topbar.addClass('fixed').addClass('sticky');
		          $('#page header').prepend(stickyDiv);
		          topbar.css({
		            top: '-' + _this.barheight + 'px',
		            width: '100%'
		          });
		          topbar.animate({
		            top: '0'
		          }, 500, function () {
		          });
		        }
		      } else {
		        // 往上滚动
		        if (topbar.hasClass('sticky')) {
		          topbar.removeClass('sticky');
		          topbar.animate({
		            top: '-' + _this.barheight + 'px'
		          }, 100, function () {
		            // $('.sticky-placeholder').remove();
		            topbar.removeClass('fixed');
		          });
		          //_this.fadeOut('fast', function () {
		          //  _this.fadeIn('fast');
		          //});
		        }
		      }
		    });
		  }
		}
	}

	new ScrollHead($(".header-bar-container"));
});