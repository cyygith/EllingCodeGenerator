<template>
    <div class="${sign}-panel">
        <div class="head-panel">
            <button @click="backBefore"  class="btnclass head-back"><&nbsp;编辑房屋</button>
            <button class="btnclass head-save" @click="saveOrUpdate">保存</button>
        </div>
        <div class="content-panel">
        	<#list colsEntityNoKey as result><#--循环输出变量 start-->
            <div class="c-item" v-if="showItem=='${result.colunm}'">
                <input type="number" placeholder="请输入${result.comment}"  class="c-input" name="${result.colunm}" v-model="form.${result.colunm}">
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
        this.id = this.$route.query.id;
        this.form.id = this.$route.query.id;
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
        // 获取详情
        detail(){
            let ${primaryKey} = this.$route.query.${primaryKey};
            let param = new URLSearchParams();
            param.append("${primaryKey}",${primaryKey});
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
