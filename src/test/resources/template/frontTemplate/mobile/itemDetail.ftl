<template>
    <div class="${sign}-panel">
        <div class="head-panel">
            <button @click="backBefore"  class="btnclass head-back">< 退回</button>
        </div>
        <div class="content-panel">
        	<#list colsEntityNoKey as result><#--循环输出变量 start-->
        	<div class="c-item">
                <div class="cc-name">${result.comment}</div>
                <div class="cc-value">{{form.${result.colunm}}}</div>
            </div>
        	</#list>
        </div>
    </div>
</template>
<script>
import {${sign}Api} from "@/service/${sign}-api";
export default {
    data() {
        return {
            id:'',
            form:{
                <#list colsEntity as result>
            	${result.colunm}:null,
            	</#list>
            },
        }
    },
    computed:{

    },
    mounted(){
        this.detail();
    },
    watch:{
    
    },
    methods:{
        // 閫�鍑虹櫥褰�
        logout(){
            this.$router.push('/login');
        },
        //杩斿洖涓婁竴椤�
        backBefore(){
            this.$router.back(-1);
        },
        // 鑾峰彇璇︽儏
        detail(){
            let ${primaryKey} = this.$route.query.${primaryKey};
            let param = new URLSearchParams();
            param.append("${primaryKey}",${primaryKey});
            let loading = this.$loading({lock:true,text:'鑾峰彇涓�....',background:'rgba(0,0,0,0.5)'});
            ${sign}Api.getByCondition(param).then((res)=>{
                if(res.code == "0"){
                    if(res.data){    
                        this.form = res.data;
                    }
                }else{
                    this.$alert('鑾峰彇淇℃伅澶辫触锛岃仈绯荤鐞嗗憳','鎻愮ず淇℃伅');
                }
                loading.close();
            });	
        },
    }
}
</script>

<style lang="scss" scoped>
@import '../../../assets/css/custom-module/mobileCommon.css';
.${sign}-panel{
    background-color: grey;
    position: relative;
    .c-item{
        display: flex;
        flex-direction: row;
        width: 100%;
        padding: 1rem;
        background-color: white;
        border-bottom: 1px solid rgb(214, 210, 210);
    }
        .cc-name{
            width: 5rem;
        }
        .cc-value{
            flex-grow: 1;
            text-align: right;  
            margin-right: 2rem;
        }
            .ccc-span{
                font-weight: bold;
                margin-left: 0.5rem;
            }
        .cc-amount{
            color: red;
            font-size: 1.3rem;
        }
    .smallsize{
        size: 0.5rem;
        color:grey;
    }
}
</style>
