<template>
    <div class="list-panel">
        <div class="head-panel">
            <button @click="backBefore" class="btnclass head-back">< 退回</button>
            <button @click="detail" class="btnclass head-save">查看</button>
            <button @click="add" class="btnclass head-save">新增</button>
            <button @click="del" class="btnclass head-save">删除</button>
        </div>
        <div class="overflow-content">
	        <div class="content-panel" v-for='(tItem,tIndex) in tableData' :key="tIndex" :class="[{'chooseDiv':chooseDiv==tItem.id}]" @click="choose(tItem);">
	            <div class="c-img" @click="toDetail(tItem)">{{tItem.id}}</div>
	            <div class="c-other">
	                <div class="cc-room">{{tItem.groupName}} {{tItem.houseName}}</div>
	                <div class="cc-content">
	                    <span class="ccc-time">{{tItem.createTime}}</span> 
	                    <span class="ccc-money">{{tItem.status==='1'?'启用':'禁用'}}</span>
	                </div>
	            </div>
	        </div>
        </div>
        <div class="load-more" v-if="this.page.totalCount>this.page.pageSize">加载更多...</div>
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
            tableData:[],
            page:{
            	pageSize:10,
            	currPage:1,
            	totalPage:0
            },
            chooseDiv:'',
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
        //选中div
        choose(item){
            this.chooseDiv = item.id;
            this.chooseItem = item;
        },
        //编辑详情
        toDetail(item){
            this.$router.push({path:'${modelNameLowerCamel}Detail',query:{id:item.id}});
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
            }).catch(error=>{
                loading.close();
            });	
        },
        //修改
        detail(){
            this.$router.push({path:'${modelNameLowerCamel}',query:{id:this.chooseItem.id}});
        },
        //新增
        add(){
            this.$router.push({path:'${modelNameLowerCamel}Modify',query:{ifNew:true}});
        },
        //删除
        del() {
            this.$confirm('确定删除该记录?', '提示', {confirmButtonText: '确定',cancelButtonText: '取消',type: 'warning'}).then(() => {
                let param = new URLSearchParams();
                param.append("id",this.chooseItem.id);
                ${sign}Api.delete(param).then(res => {
                    if (res.code == "0") {
                        this.$message({
                            type: 'success',
                            message: '删除成功!',
                            duration: 2000
                        });
                        this.queryList();
                    }else{
                        this.$message({
                            type: 'error',
                            message: '删除失败，联系管理员',
                            duration: 2000
                        });
                    }
                });
            });   
        },
    }
}
</script>

<style lang="scss" scoped>
@import '../common/commonstyle.css';
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
//选中样式
.chooseDiv{
	transform: scale(1.01);
	box-shadow: 0px 0px 18px rgba(0,0,0,0.5)
} 
</style>
