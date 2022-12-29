<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Homework2</title>
    <style>
        .page-title{
            text-align:center;
        }
        .form-container{
            width:360px;
            margin:60px auto;
            font-size:20px;
        }
        .form-container .form-item{
            display:flex;
        }
        .form-item + .form-item{
            margin-top:10px;
        }
        .form-container label{
            display: block;
            min-width:130px;
            width:130px;
            line-height:32px;
        }
        .form-container label + .coin-generator {
            width:calc(100% - 130px);
        }
        .coin-generator .btn-func{
            min-width:30px;
            font-size:18px;
            cursor: pointer;
        }
        .form-container input[type=text] {
            font-size:16px;
            padding:5px 10px;
        }
        .coin-header{
            display: flex;
            margin:10px 0;
        }
        .coin-header h5{
            margin:0;
            width:120px;
        }
        .coin-header h5 + h5{
            width:calc(100% - 120px);
        }
        .coin-input{
            display:flex;
            width:calc(100% - 130px);
            min-width:230px;
        }
        .coin-input + .coin-input{
            margin-top:8px;
        }
        .coin-input .input-coin{
            width:100px;
            margin-right:20px;
            padding:0;
            box-sizing: border-box;
        }
        .coin-input .input-coin-count{
            width:80px;
            margin:0;

        }
        .form-container .btn-group{
            margin-top:40px;
            justify-content: center;
        }
        .form-container .btn-group .btn-calc{
            width:100%;
            padding:5px 20px;
            cursor: pointer;
            font-size:20px;

        }
    </style>
</head>
<body>
<h2 class="page-title">Homework2 - 알고리즘</h2>
<form action="">
    <section class="form-container">
        <article class="form-item">
            <label for="">지폐금액</label>
            <input type="text" class="input-amount" id="" name="" placeholder="0<T<=10,000">
        </article>
        <article class="form-item">
            <label>동전의 가지 수</label>
            <div class="coin-generator">
                <button type="button" class="btn-func btn-add">+</button>
                <button type="button" class="btn-func btn-minus">-</button>
                <div class="coin-header">
                    <h5>동전금액</h5>
                    <h5>개수</h5>
                </div>
                <div class="coin-input">
                    <input type="text" class="input-coin" name="" placeholder="Pi" onchange="handleCoinChange(this)">
                    <input type="text" class="input-coin input-coin-count" name="" placeholder="Ni" onchange="handleCoinChange(this)">
                </div>
            </div>
        </article>
        <article class="form-item btn-group">
            <button type="button" class="btn-calc">계산</button>
        </article>
    </section>
</form>

<script>

    (()=> {
        const btnAdd = document.querySelector(".btn-add");
        const btnMinus = document.querySelector(".btn-minus");
        const amount = document.querySelector(".input-amount");
        const btnCalc = document.querySelector(".btn-calc");

        btnAdd.addEventListener("click", addCoinType);
        btnMinus.addEventListener("click", minusCoinType);
        amount.addEventListener("keyup", checkAmount);
        btnCalc.addEventListener("click", submitForm);
    })();
    let coins = {};

    /**
     * 동전 입력 추가
     */
    function addCoinType() {
        const container = document.querySelector(".coin-generator");
        const tempDiv = document.createElement("div");
        tempDiv.className = "coin-input";

        tempDiv.innerHTML = `
                    <input type="text" class="input-coin" name="" placeholder="Pi" onchange="handleCoinChange(this)">
                    <input type="text" class="input-coin input-coin-count" name="" placeholder="Ni" onchange="handleCoinChange(this)">
                `;

        container.append(tempDiv);
    }


    /**
     * 동전 입력 빼기
     */
    function minusCoinType() {
        const lastItem = document.querySelectorAll(".coin-input");
        const leng = lastItem.length;
        if(lastItem.length < 2) {
            return;
        }

        lastItem[leng-1].remove();
    }


    /**
     * 금액 유효성 검사, 금액 형식 표현
     * @param e
     */
    function checkAmount(e) {
        let amount = this.value;
        amount = Number(amount.replaceAll(",",""));

        if(isNaN(amount) || amount > 10000){
            this.value = "";
            alert("10,000 이하의 숫자만 입력 가능합니다.");
        } else {
            if(amount > 999){
                this.value = amount.toLocaleString("ko-KR");
            }
        }
    }




    /**
     * 지폐, 동전 정보 제출
     */
    function submitForm(){

        const inputAmount = document.querySelector(".input-amount");
        const inputCoin = document.querySelectorAll(".input-coin");

        if(inputAmount.value == "") {
            alert("지폐금액을 입력하세요.");
            return;
        } else if (Object.keys(coins).length < 1) {
            alert("동전 가지 수를 입력하세요.");
            return;
        }



        const amount = inputAmount.value.replaceAll(",", "");

        fetch("/getCalcResult", {
            method: "POST",
            headers: {
                "Content-Type":"application/json",
                //"Accept" : "application/json"
            },
            body:JSON.stringify({
                "amount" : Number(amount),
                "count" : Object.keys(coins).length,
                "list" : coins

            })

        })
            .then((response) => response.json())
            .then((data) => alert("총 "+ data + " 가지"))
    }

    /**
     *
     * @param obj
     */
    function handleCoinChange(obj){

        const val = obj.value;
        const coin = Number(val);
        const coinInput = document.querySelectorAll(".coin-input");
        coins = {};
        if(isNaN(coin) || coin > 999){
            obj.value = "";
            return;
        }

        coinInput.forEach(function(item, index) {
            const inputCoin = item.querySelector(".input-coin");
            const inputCoinCount = item.querySelector(".input-coin-count");

            if(inputCoin.value != "" && inputCoinCount.value != "") {
                if(coins[inputCoin.value] !== undefined) {
                    coins[inputCoin.value] = Number(inputCoinCount.value) + Number(coins[inputCoin.value]);
                } else {
                    coins[inputCoin.value] = Number(inputCoinCount.value);
                }

            }

        })

    }



</script>
</body>
</html>
