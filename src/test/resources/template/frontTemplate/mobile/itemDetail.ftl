<template>
    <div class="${sign}-panel">
        <div class="head-panel">
            <button @click="backBefore"  class="btnclass head-back">< 退回</button>
        </div>
        <div class="content-panel">
        	<#list colsEntityNoKey as result><#--循环输出变量 start-->
        	<#if result.dealType=='select'>
        	<div class="c-item">
        		<div class="cc-name">${result.comment}</div>
        		<div class="cc-value" @click="toEdit('${result.colunm}',form.${result.colunm});">{{${result.colunm}Name}}<span class="ccc-span">></span></div>
        	</div>
        	<#else >
        	<div class="c-item">
                <div class="cc-name">${result.comment}</div>
                <div class="cc-value">{{form.${result.colunm}}}</div>
            </div>
            </#if>
        	</#list>
        </div>
        <div class="foot-panel"> </div>
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
            <#list colsEntity as result>
        	<#if result.dealType=='select'>
        	${result.colunm}Name:{},//${result.comment}名称
        	</#if>
        	</#list>
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
         // 退出登录
        logout(){
            this.$router.push('/login');
        },
        //返回上一页
        backBefore(){
            this.$router.back(-1);
        },
        //编辑详情
        detail(){
            let ${primaryKey} = this.$route.query.id;
            let param = new URLSearchParams();
            param.append("id",${primaryKey});
            let loading = this.$loading({lock:true,text:'获取中....',background:'rgba(0,0,0,0.5)'});
            ${sign}Api.getByCondition(param).then((res)=>{
                if(res.code == "0"){
                    if(res.data){    
                        this.form = res.data;
                        
                        <#list colsEntity as result>
			        	<#if result.dealType=='select'>
			        	//${result.comment}
			        	this.dictApi.getDictByType({"typeCode":this.dictApi.dict.typeCodeCd.${result.colunm}}).then((val)=>{
			                this.${result.colunm}Name = val;
			            });
			        	</#if>
			        	</#list>
                    }
                }else{
                    this.$alert('获取信息失败，联系管理员','提示信息');
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
