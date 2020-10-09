<template>
    <div class="list-panel">
        <div class="head-panel">
            <button class="btnclass head-back">< 退回</button>
        </div>
        <div class="content-panel" v-for='(tItem,tIndex) in tableData' :key="tIndex">
            <div class="c-img">{{tItem.houseCode}}</div>
            <div class="c-other" @click="toDetail(tItem)">
                <div class="cc-room">{{tItem.groupName}} {{tItem.houseName}}</div>
                <div class="cc-content">
                    <span class="ccc-time">{{tItem.startTime}}-{{tItem.endTime}}</span> 
                    <span class="ccc-money">{{tItem.money}}元</span>
                </div>
            </div>
        </div>
        <div class="load-more">加载更多...</div>
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
            tableData:[],
            page:{
            	pageSize:10,
            	currPage:1,
            	totalPage:0
            },
        }
    },
    computed:{

    },
    mounted(){
        this.queryList();
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
        nextPage(){
        	this.page.currPage = this.page.currPage + 1;
            this.queryList();
        },
        lastPage(){
        	this.page.currPage = this.page.currPage-1;
            this.queryList();
        },
        //编辑详情
        toDetail(item){
            this.$router.push({path:'rentBillDetail',query:{id:item.id}});
        },
        // 获取详情
        queryList(){
            let houseCode = this.$route.query.houseCode;
            let param = new URLSearchParams();
            param.append("page",this.page.currPage);
            param.append("size",this.page.pageSize);
            let loading = this.$loading({lock:true,text:'获取中....',background:'rgba(0,0,0,0.5)'});
            ${sign}Api.list(param).then((res)=>{
                if(res.code == "0"){
                  this.tableData = res.data.list;
                  this.page.pageSize = res.data.pageSize;
                  this.page.totalCount = res.data.total;
                }else{
                  this.$message({showClose:true,message:'程序出现异常，请联系管理员处理'});
                  //this.$alert('获取信息失败，联系管理员','提示信息');
                }
                loading.close();
            });	
        },
    }
}
</script>

<style lang="scss" scoped>
@import '../../../assets/css/custom-module/mobileCommon.css';
.list-panel{
    background-color: rgb(241, 238, 238);
    .content-panel{
        background-color: white;
        padding: 0.5rem;
        margin: 0.5rem;
        line-height: 1.5rem;
        display: flex;
        flex-direction: row;
        width: 100%;
    }   
        .c-img{
            padding: 1rem;
            background-color: lightgreen;
            border-radius: 50%;
            margin-right: 1rem;
        }
        .c-other{
            flex-grow: 1;
            margin-right: 2rem;
        }
                .ccc-time{
                    font-size: 0.7rem;
                    color: grey;
                    
                }
                .ccc-money{
                    float: right;
                    color: blue;
                    
                }
    .foot-panel{
        padding: 0.3rem;
    }
    .load-more{
    	text-align:center;
    }
}
</style>
