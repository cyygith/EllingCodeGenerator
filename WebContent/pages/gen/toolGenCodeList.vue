<template>
    <div id="itemlist-panel" class="itemlist-panel">
        <div class="black-panel"> &nbsp;</div>
        <div class="condition-panel">
                <el-form ref="form" :model="form" label-width="120px">
                	                	<el-row :gutter="24">
                        <el-col :span="7">
                            <el-form-item label="执行的表" prop="runTable">
                                <el-input v-model="form.runTable" size="small"></el-input>
                            </el-form-item>
                        </el-col>	
                        <el-col :span="7">
                            <el-form-item label="数据库连接URL" prop="jdbcUrl">
                                <el-input v-model="form.jdbcUrl" size="small"></el-input>
                            </el-form-item>
                        </el-col>	
                	</el-row>
                	<div v-if="queryMore">
                	<el-row :gutter="24">
                        <el-col :span="7">
                            <el-form-item label="数据库连接用户名" prop="jdbcUsername">
                                <el-input v-model="form.jdbcUsername" size="small"></el-input>
                            </el-form-item>
                        </el-col>	
                        <el-col :span="7">
                            <el-form-item label="数据库连接密码" prop="jdbcPassword">
                                <el-input v-model="form.jdbcPassword" size="small"></el-input>
                            </el-form-item>
                        </el-col>	
                        <el-col :span="7">
                            <el-form-item label="数据库驱动类" prop="jdbcDriverClassName">
                                <el-input v-model="form.jdbcDriverClassName" size="small"></el-input>
                            </el-form-item>
                        </el-col>	
                	</el-row>
                	<el-row :gutter="24">
                        <el-col :span="7">
                            <el-form-item label="数据库schema" prop="jdbcSchema">
                                <el-input v-model="form.jdbcSchema" size="small"></el-input>
                            </el-form-item>
                        </el-col>	
                        <el-col :span="7">
                            <el-form-item label="java代码存放的路径" prop="javaPath">
                                <el-input v-model="form.javaPath" size="small"></el-input>
                            </el-form-item>
                        </el-col>	
                        <el-col :span="7">
                            <el-form-item label="资源文件存放的路径" prop="resourcesPath">
                                <el-input v-model="form.resourcesPath" size="small"></el-input>
                            </el-form-item>
                        </el-col>	
                	</el-row>
                	<el-row :gutter="24">
                        <el-col :span="7">
                            <el-form-item label="模板存放的路径" prop="templateFilePath">
                                <el-input v-model="form.templateFilePath" size="small"></el-input>
                            </el-form-item>
                        </el-col>	
                        <el-col :span="7">
                            <el-form-item label="基础包名" prop="baseModel">
                                <el-input v-model="form.baseModel" size="small"></el-input>
                            </el-form-item>
                        </el-col>	
                        <el-col :span="7">
                            <el-form-item label="基础包类路径" prop="basePackage">
                                <el-input v-model="form.basePackage" size="small"></el-input>
                            </el-form-item>
                        </el-col>	
                	</el-row>
                	<el-row :gutter="24">
                        <el-col :span="7">
                            <el-form-item label="model类路径" prop="modelPackage">
                                <el-input v-model="form.modelPackage" size="small"></el-input>
                            </el-form-item>
                        </el-col>	
                        <el-col :span="7">
                            <el-form-item label="mapper类路径" prop="mapperPackage">
                                <el-input v-model="form.mapperPackage" size="small"></el-input>
                            </el-form-item>
                        </el-col>	
                        <el-col :span="7">
                            <el-form-item label="service类路径" prop="servicePackage">
                                <el-input v-model="form.servicePackage" size="small"></el-input>
                            </el-form-item>
                        </el-col>	
                	</el-row>
                	<el-row :gutter="24">
                        <el-col :span="7">
                            <el-form-item label="service实Impl类路径" prop="serviceImplPackage">
                                <el-input v-model="form.serviceImplPackage" size="small"></el-input>
                            </el-form-item>
                        </el-col>	
                        <el-col :span="7">
                            <el-form-item label="controller类路径" prop="controllerPackage">
                                <el-input v-model="form.controllerPackage" size="small"></el-input>
                            </el-form-item>
                        </el-col>	
                        <el-col :span="7">
                            <el-form-item label="作者" prop="author">
                                <el-input v-model="form.author" size="small"></el-input>
                            </el-form-item>
                        </el-col>	
                	</el-row>
                	<el-row :gutter="24">
                        <el-col :span="7">
                            <el-form-item label="时间格式化" prop="dateFormat">
                                <el-input v-model="form.dateFormat" size="small"></el-input>
                            </el-form-item>
                        </el-col>	
                        <el-col :span="7">
                            <el-form-item label="执行次数" prop="runCount">
                                <el-input v-model="form.runCount" size="small"></el-input>
                            </el-form-item>
                        </el-col>	
                        <el-col :span="7">
                            <el-form-item label="执行类" prop="runClass">
                                <el-input v-model="form.runClass" size="small"></el-input>
                            </el-form-item>
                        </el-col>	
                	</el-row>
                	<el-row :gutter="24">
                		<el-col :span="7">
                            <el-form-item label="执行时间" prop="runTime">
				                <el-date-picker v-model="form.runTime" type="date" placeholder="选择日期" size="small"></el-date-picker>
				            </el-form-item>
                        </el-col>
                	</el-row>
 					</div>
                    <el-row justify="center">
                        <el-col :span="1" :offset="7">
                            <el-button type="primary" icon="el-icon-search" @click="queryList" size="small">查 询</el-button>
                        </el-col>
                        <el-col :span="1" :offset="1">
                            <el-button plain icon="el-icon-switch-button" size="small" @click="resetForm">重 置</el-button>
                        </el-col>
                        <el-col :span="1" :offset="1">
                            <el-button type="text" icon="queryMore==false?'el-icon-arrow-down':'el-icon-arrow-up'" size="small" @click="queryMore==true?queryMore=false:queryMore=true">更多查询</el-button>
                        </el-col>
                    </el-row>
                </el-form>
        </div>

        <div class="list-panel">
            <div class="list-button-p">
                <el-row>
		          <el-col :span="1">
		            <el-button type="primary" icon="el-icon-search" @click="add" size="small">新增</el-button>
		          </el-col>
		          <el-col :span="1" :offset="1">
		            <el-button type="primary" icon="el-icon-s-custom" @click="del" size="small">删除</el-button>
		          </el-col>
		        </el-row>
            </div>
            <div class="list-list">
                <el-table border style="width: 100%" :data="tableData" ref="multipleTable">
                        <el-table-column fixed type="selection" width="40"></el-table-column>
                        <el-table-column prop="id" label="" v-show="false"></el-table-column>
                        <el-table-column prop="runTable" label="执行的表"></el-table-column>
                        <el-table-column prop="jdbcUrl" label="数据库连接URL"></el-table-column>
                        <el-table-column prop="jdbcUsername" label="数据库连接用户名"></el-table-column>
                        <el-table-column prop="jdbcPassword" label="数据库连接密码"></el-table-column>
                        <el-table-column prop="jdbcDriverClassName" label="数据库驱动类"></el-table-column>
                        <el-table-column prop="jdbcSchema" label="数据库schema"></el-table-column>
                        <el-table-column prop="javaPath" label="java代码存放的路径"></el-table-column>
                        <el-table-column prop="resourcesPath" label="资源文件存放的路径"></el-table-column>
                        <el-table-column prop="templateFilePath" label="模板存放的路径"></el-table-column>
                        <el-table-column prop="baseModel" label="基础包名"></el-table-column>
                        <el-table-column prop="basePackage" label="基础包类路径"></el-table-column>
                        <el-table-column prop="modelPackage" label="model类路径"></el-table-column>
                        <el-table-column prop="mapperPackage" label="mapper类路径"></el-table-column>
                        <el-table-column prop="servicePackage" label="service类路径"></el-table-column>
                        <el-table-column prop="serviceImplPackage" label="service实Impl类路径"></el-table-column>
                        <el-table-column prop="controllerPackage" label="controller类路径"></el-table-column>
                        <el-table-column prop="author" label="作者"></el-table-column>
                        <el-table-column prop="dateFormat" label="时间格式化"></el-table-column>
                        <el-table-column prop="runCount" label="执行次数"></el-table-column>
                        <el-table-column prop="runClass" label="执行类"></el-table-column>
                        <el-table-column prop="runTime" label="执行时间"></el-table-column>
                        <el-table-column fixed="right" label="操作" width="160">
				            <template slot-scope="scope">
				              <el-button @click="update(scope.row)" type="warning" size="mini">编辑</el-button>
				              <el-button @click="detail(scope.row)" type="primary" size="mini">查看</el-button>
				            </template>
				        </el-table-column>
                </el-table>
            </div>
            <div class="list-page">
                <el-pagination
                    @size-change="handleSizeChange"
                    @current-change="handleCurrentChange"
                    :current-page.sync="page.currPage"
                    :page-sizes="[5,10,20,30,40]"
                    :page-size="page.pageSize"
                    layout="total, sizes, prev, pager, next, jumper"
                    :total="page.totalCount">
                </el-pagination>
            </div>    
        </div>
        <div class="black-panel"> &nbsp;</div>
        <div class="popdialog-container">
            <el-dialog 
                :title="dialogTitle"
                width="60%"
                v-if='dialogVisible'
                :visible.sync="dialogVisible"
                :close-on-click-modal="false"
                :before-close="handleClose">
                <tool-gen-code :checkrow="checkRow" @closechild="closechild"></tool-gen-code>
            </el-dialog>
        </div>
    </div>
</template>
<script>
import toolGenCode from "@/components/page/tool/gen/toolGenCodeManager"
import {genApi} from "@/service/sys-api";
export default {
	name:'toolGenCode',
    data(){
        return {
            dialogVisible:false,
            visible:false,
            form:{
            	runTable:'',
            	jdbcUrl:'',
            	jdbcUsername:'',
            	jdbcPassword:'',
            	jdbcDriverClassName:'',
            	jdbcSchema:'',
            	javaPath:'',
            	resourcesPath:'',
            	templateFilePath:'',
            	baseModel:'',
            	basePackage:'',
            	modelPackage:'',
            	mapperPackage:'',
            	servicePackage:'',
            	serviceImplPackage:'',
            	controllerPackage:'',
            	author:'',
            	dateFormat:'',
            	runCount:'',
            	runClass:'',
            	runTime:'',
            },
            page:{
            	pageSize:5,
            	currPage:1,
            	totalPage:0
            },
            tableData: [],
            checkRow:{}, //选择的条数
            queryMore:false,  //查询更多
            dialogTitle:'新增'
        }
    },
    components:{
        'tool-gen-code' : toolGenCode
    },
    mounted(){
        
    },
    methods:{
    	//改变每页条数
        handleSizeChange(val) {
            this.page.pageSize = val;
            this.queryList();
        },
        //改变当前页面
        handleCurrentChange(val) {
            this.page.currPage = val;
            this.queryList();
        },
        //关闭弹出窗口
        handleClose(done) {
            this.dialogVisible = false;
        },
        //关闭子窗口
        closechild(){
        	this.dialogVisible = false;
        	//this.queryList();
        },
        //重置
        resetForm(){
        	this.$refs['form'].resetFields();
        },
        //查询list数据
        queryList() {
	        let param = Object.assign({}, this.form);
	        param.size = this.page.pageSize;
	        param.page = this.page.currPage;
	        
	        let loading = this.$loading({lock:true,text:'处理中....',background:'rgba(0,0,0,0.5)',target: document.querySelector('.list-panel')});
	        genApi.list(param).then((res)=>{
                if(res.code == "0"){
                  this.tableData = res.data.list;
                  this.page.pageSize = res.data.pageSize;
                  this.page.totalCount = res.data.total;
                }else{
                  this.$message({showClose:true,message:'程序出现异常，请联系管理员处理'});
                }
                loading.close();
	        });
	    },
	    //新增
	    add() {
	      this.checkRow.selArr = this.$refs.multipleTable.selection;
	      this.dialogVisible = true;
	      this.checkRow.type='add';
	      this.dialogTitle = "新增";
	    },
	    //修改
	    update(row) {
	      this.checkRow.selArr = row;
	      this.checkRow.type='update';
	      this.dialogVisible = true;
	      this.dialogTitle = "修改";
	    },
	    //查看详情
	    detail(row){
	      this.checkRow.selArr = row;
	      this.checkRow.type='detail';
	      this.dialogVisible = true;
	      this.dialogTitle = "查看详情";
	    },
	    //删除
	    del(){
	      this.checkRow.type='del';
	      let ll = this.$refs.multipleTable.selection;
	      if(ll.length<1){
	          this.$message({ showClose: true, type: 'warning',  message: '请选择删除的行！', duration:2000 });
	      }
	      let idArr = ll.map((e,i)=>{
	        return e.ID;
	      });
	      let param = {
	        ids:idArr.join(",")
	      }
	
	      genApi.deleteByIds(param).then((res)=>{
                if(res.code == "0"){
                  this.$message({
                    showClose: true,
                    message: '删除成功！',
                    duration:2000
                  });
                  this.queryList();//关闭后刷新界面
                }else{
                  this.$message({showClose:true,message:'删除失败，程序出现异常，请联系管理员处理'});
                }
	        });
	    },
	    
    }
}
</script>
<style lang="scss" scoped>
@import 'src/components/page/style/normal'; 
</style>

