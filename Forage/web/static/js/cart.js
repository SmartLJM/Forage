$(function(){
    function Cart(){
        this.productList = [];
        this.totalNum = 0;
        this.totalCost = 0;

        this.restaurantId = 0;

        this.$addOneBtns = $(".add-btn");
        this.$clearcart = $(".clearcart");
        this.$cart = $("#cart");
        this.$foods = this.$cart.find(".foods");
        this.$costNum = this.$cart.find(".cost-num");
        this.$costAmount = this.$cart.find(".amount");

        this.numByBtn = "<span class=\"num\">1</span>";

        this.init();
    };

    Cart.prototype = {
        init:function(){
            var _this = this;
            this.restaurantId = $("#restaurant").data("id");
            var data = {
                restaurantId: this.restaurantId
            }
            // 向服务器请求购物车数据
            $.ajax({
                url:"/Forage/cart/list",
                method:"POST",
                data:data,
                success:function(result){
                    if(result.status == 1){
                        var cart = result.data;
                        console.log(result);
                        console.log(cart);
                        $.each(cart, function(key, food){

                            var item = {};
                            // 创建购物车项
                            item.id = food.id;
                            item.price = food.price;
                            item.name = food.name;
                            item.num = food.num;

                            item.$numByBtn = _this.createNumByBtn(item.num);
                            item.$cartItem = _this.createCartItem(item);
                            item.$num = item.$cartItem.find(".num");

                            _this.productList.push(item);

                            var $foodCart = $("#" + item.id);
                            var $addBtn = $foodCart.find(".add-btn");

                            _this.appendToCart(item);
                            $addBtn.before(item.$numByBtn);
                            // 事件绑定
                            // $(".cart-add" ).on("click",$.proxy(_this.increaseOne, _this));

                        });
                    }else{
                        alert(result.message);
                    }
                },
                error:function(result){
                    alert(result.message);
                }
            });

            this.addListener();
        },

        addListener:function(){
            // 为每个商品添加点击事件
            // this.$addOneBtns.on("click",$.proxy(this.clickAddOne, this));
            $(document).on("click",".add-btn",$.proxy(this.clickAddOne, this));
            // $(".cart-add" ).on("click",$.proxy(this.increaseOne, this));
            // $(".cart-add" ).on("click",this.increaseOne);
            // $(document).on("click",".cart-sub",this.decreaseOne);

            // $(document).on("click",".cart-sub",$.proxy(this.decreaseOne, this));
            // $(document).on("click",".cart-add",$.proxy(this.increaseOne, this));

            this.$clearcart.on("click",$.proxy(this.clearCart, this));
            // [TODO]连接后台后用这个
            $(document).on("click",".cart-sub",{action:"decrease"},$.proxy(this.changeCartItemNum, this));
            $(document).on("click",".cart-add",{action:"increase"},$.proxy(this.changeCartItemNum, this));
        },

        clickAddOne:function(e){
            var data =  $(e.target).data();
            // var num = $(e.target).attr("data-num");
            var _this = this;
            var exist = false;
            var foodId =  $(e.target).data("id");
            var data_send = {
                restaurantId:_this.restaurantId,
                foodId:foodId
            };
            console.log(data_send);
            $.ajax({
                url: "/Forage/cart/operate/increase",
                method:"POST",
                data: data_send,
                success: function (result) {
                    if(result.status == 0){
                        _this.alert(result.message);
                        return;
                    }
                    // 寻找数组的指定元素
                    $.each( _this.productList, function( key, item ) {
                        if(item.foodId == data.id){
                            // 找到购物车中的项
                            item.$numByBtn.text(parseInt(item.num)+1);
                            item.num += 1*1;

                            item.$num.val(parseInt(item.num));

                            var curNum = _this.$costNum.text();

                            _this.$costNum.text(parseInt(curNum) + 1);
                            _this.$costAmount.text(parseInt(_this.$costAmount.text())+ item.price);

                            exist = true;
                        }
                    });
                    // console.log(data);
                    // console.log( $(e.target));
                    // 购物车内没有该商品

                    if(!exist){
// 创建购物车项
                        var item = {};

                        item.foodId = data.id;
                        // console.log(item);
                        // 插入购物车
                        item.price = data.price;
                        item.name = data.name;
                        item.num = 1;


                        item.$numByBtn = $(_this.numByBtn);
                        item.$cartItem = _this.createCartItem(item);
                        item.$num = item.$cartItem.find(".num");

                        // 显示图标
                        $(e.target).before(item.$numByBtn);
                        $(e.target).attr("data-num",1);

                        _this.appendToCart(item);
                        _this.productList.push(item);
                    }
                },
                error: function (result) {
                    _this.alert(result.message);
                }
            });
        },

        increaseOne:function(e){
            var _this = this;

            // console.log(this);
            // console.log($(e.target));
            var data =  $(e.target).data();
            // console.log(data.id);

            $.each( this.productList, function( key, item ) {

                if(item.foodId == data.id){
                    // 找到购物车中的项
                    item.$numByBtn.text(parseInt(item.num)+1);
                    item.num += 1*1;

                    item.$num.val(parseInt(item.num));

                    var curNum = _this.$costNum.text();

                    _this.$costNum.text(parseInt(curNum) + 1);
                    _this.$costAmount.text(parseInt(_this.$costAmount.text())+ item.price);
                }
            });
        },

        decreaseOne:function(e){
            var _this = this;

            // console.log(this);
            // console.log($(e.target));
            var data =  $(e.target).data();
            // console.log(data.id);


            for (var i = 0; i < this.productList.length; i ++){
                // $.each( this.productList, function( key, item ) {

                var item = this.productList[i];

                if(item.foodId == data.id){
                    // 找到购物车中的项
                    item.$numByBtn.text(parseInt(item.num)-1);
                    item.num -= 1*1;

                    item.$num.val(parseInt(item.num));

                    var curNum = _this.$costNum.text();

                    _this.$costNum.text(parseInt(curNum) - 1);
                    _this.$costAmount.text(parseInt(_this.$costAmount.text()) - item.price);

                    if(item.num <= 0){
                        // 移除
                        item.$cartItem.remove();
                        item.$numByBtn.remove();
                        _this.productList.splice(i,1);
                    }
                }
            }
        },

        changeCartItemNum:function(e){

            var _this = this;
            // var distNum = e.data.distNum > 0 ? 1 : -1;
            var action = e.data.action;

            var foodId =  $(e.target).data("id");

            var data = {
                restaurantId:_this.restaurantId,
                foodId:foodId
            };
            $.ajax({
                url:"/Forage/cart/operate/" + action,
                method:"POST",
                data:data,
                success:function(result){
                    if(result.status == 0){
                        _this.alert(result.message);
                        return;
                    }
                    for (var i = 0; i < _this.productList.length; i ++){

                        var item = _this.productList[i];

                        if(item.foodId == foodId){
                            // 找到购物车中的项
                            item.$numByBtn.text(parseInt(item.num)+distNum);
                            item.num += distNum*1;

                            item.$num.val(parseInt(item.num));

                            var curNum = _this.$costNum.text();

                            _this.$costNum.text(parseInt(curNum) + distNum);
                            _this.$costAmount.text(parseInt(_this.$costAmount.text()) + distNum * item.price);

                            if(item.num <= 0){
                                // 移除
                                item.$cartItem.remove();
                                item.$numByBtn.remove();
                                _this.productList.splice(i,1);
                            }
                        }
                    }
                },
                error:function(result){
                    _this.alert(result.message);
                }
            });
        },

        clearCart:function(){
            var _this = this;
// 测试
            _this.$costNum.text(0);
            _this.$costAmount.text(0);

            for (var i = 0; i < _this.productList.length; i ++){
                var item = _this.productList[i];
                // 移除
                item.$cartItem.remove();
                item.$numByBtn.remove();
            }

            _this.productList = [];


            var data = {
                restaurantId:restaurantId
            };

            $.ajax({
                url:"/Forage/cart/operate/clear",
                method:"POST",
                data:data,
                success:function(result){

                    _this.$costNum.text(0);
                    _this.$costAmount.text(0);

                    for (var i = 0; i < _this.productList.length; i ++){
                        var item = _this.productList[i];
                        // 移除
                        item.$cartItem.remove();
                        item.$numByBtn.remove();
                    }

                    _this.productList = [];
                },
                error:function(result){
                    _this.alert(result.message);
                }
            });
        },

        createCartItem:function(item){

            var itemStr = [];
            itemStr.push('<li class="food-item">');
            itemStr.push('<div class="food-name tag-left">');
            itemStr.push(item.name);
            itemStr.push("</div>");
            itemStr.push('<div class="food-num tag-left">');
            itemStr.push('<div class="subadd">');
            itemStr.push('<a href="javascript:;" class="cart-sub" data-id="'+ item.foodId +'">-</a>');
            itemStr.push('<input type="text" class="num" value="' + item.num + '"/>');
            itemStr.push('<a href="javascript:;" class="cart-add" data-id="'+ item.foodId +'">+</a>');
            itemStr.push("</div>");
            itemStr.push("</div>");
            itemStr.push('<div class="food-price tag-left">');
            itemStr.push("￥" + '<span class="price">' + item.price + '</span>');
            itemStr.push("</div>");
            itemStr.push("</li>");

            return $(itemStr.join("\n"));
        },

        createNumByBtn:function(num){
            var str = "<span class=\"num\">" + num + "</span>";
            return $(str);
        },

        appendToCart:function(item){
            this.$foods.append(item.$cartItem);

            var curNum = this.$costNum.text();

            this.$costNum.text(curNum*1 + 1);
            this.$costAmount.text(this.$costAmount.text()*1+ item.price);
        },

        submitNumToService:function(restaurantId, foodId, num){

        },

        alert:function(msg){
            alert(msg);
        }

    }

    new Cart();
});