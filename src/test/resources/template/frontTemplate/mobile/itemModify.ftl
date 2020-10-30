<template>
    <div class="${sign}-panel">
        <div class="head-panel">
            <button @click="backBefore"  class="btnclass head-back"><&nbsp;退回</button>
            <button class="btnclass head-save" @click="saveOrUpdate">保存</button>
        </div>
        <div class="content-panel">
        	<#list colsEntityNoKey as result><#--循环输出变量 start-->
        	<#if result.dealType=='select'>
        	<div class="c-item" v-if="ifNew||showItem==='${result.colunm}'">
        		<div>${result.comment}:</div>
        		<span class="c-g-item" v-for='(val,key) in ${result.colunm}s' :key="key" @click="changeWhenClick(${result.colunm},key);" :class="{'c-g-item-this':form.${result.colunm}==key}">{{val}}</span>
        	</div>
        	<#elseif result.dealType=='time'><#--如果是时间则打印对应时间控件等-->
        	<div class="c-item" v-if="ifNew||showItem==='${result.colunm}'">
        		<div>${result.comment}:</div>
        		<el-date-picker format="yyyy-MM-dd" value-format="yyyy-MM-dd" v-model="form.endTime"> </el-date-picker>
        	</div>
        	<#else >
            <div class="c-item" v-if="ifNew||showItem==='${result.colunm}'">
                <div>${result.comment}:</div>
                <input placeholder="请输入${result.comment}"  class="c-input" name="${result.colunm}" v-model="form.${result.colunm}">
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
            ifNew:false, //是否为新增，如果新增，则不加一个个过滤
            showItem:'',
            showItemValue:'',
            <#list colsEntity as result>
        	<#if result.dealType=='select'>
        	${result.colunm}s:{},//${result.comment}列表
        	</#if>
        	</#list>
            
        }
    },
    computed:{

    },
    mounted(){
        this.showItem = this.$route.query.showItem;
        this.form[this.showItem] = this.$route.query.showItemValue;
        this.ifNew = this.$route.query.ifNew;
        if(!this.ifNew){ //如果不是新的，则查询
            this.detail();
        };
        this.initDict();//初始化字典数据
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
        //点击触发
        changeWhenClick(field,val){
            this.form[field] = val;
        },
        //初始化字典数据,如果为空可以删除
        initDict(){           
            <#list colsEntity as result>
        	<#if result.dealType=='select'>
        	//${result.comment}
        	this.dictApi.getDictByType({"typeCode":this.dictApi.dict.typeCodeCd.${result.colunm}}).then((item)=>{
                this.${result.colunm}s = item;
            });
        	</#if>
        	</#list>
        },
        // 获取详情
        detail(){
            let ${primaryKey} = this.$route.query.id;
            let param = new URLSearchParams();
            param.append("id",${primaryKey});
            let loading = this.$loading({lock:true,text:'获取中....',background:'rgba(0,0,0,0.5)'});
            ${sign}Api.getByCondition(param).then((res)=>{
                if(res.code == "0"){
                    if(res.data){    
                        this.form = res.data;
                    }
                }else{
                    this.$alert('获取信息失败，联系管理员','提示信息');
                }
                loading.close();
            }).catch(error=>{
                loading.close();
            });	
        },
        //保存到数据库
        saveOrUpdate(){
            let param = this.form;
            let loading = this.$loading({lock:true,text:'保存中....',background:'rgba(0,0,0,0.5)'});
            ${sign}Api.saveOrUpdate(param).then((res)=>{
                if(res.code == "0"){
                    this.$message({
                        message: '提交成功',
                        center: true,
                        type: 'success',
                        customClass:'customClass',
                        offset:300
                    })
                    this.$router.back(-1);
                }else{
                    this.$alert('提交失败，请联系管理员处理','提示信息');
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
        line-height: 2rem;
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
