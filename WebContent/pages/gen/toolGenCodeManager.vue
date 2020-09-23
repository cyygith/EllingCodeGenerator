<template>
    <div id="itemManager-container">
        <div class="form-container">
            <el-form ref="form" :rules="rules" :model="form" label-width="100px">
            	            	<el-row :gutter="24">
                    <el-col :span="12">
                        <el-form-item label="执行的表" prop="runTable">
                            <el-input v-model="form.runTable" size="small" :disabled="isDetail"></el-input>
                        </el-form-item>
                    </el-col>	
            	</el-row>
            	<el-row :gutter="24">
                    <el-col :span="12">
                        <el-form-item label="数据库连接URL" prop="jdbcUrl">
                            <el-input v-model="form.jdbcUrl" size="small" :disabled="isDetail"></el-input>
                        </el-form-item>
                    </el-col>	
                    <el-col :span="12">
                        <el-form-item label="数据库连接用户名" prop="jdbcUsername">
                            <el-input v-model="form.jdbcUsername" size="small" :disabled="isDetail"></el-input>
                        </el-form-item>
                    </el-col>	
            	</el-row>
            	<el-row :gutter="24">
                    <el-col :span="12">
                        <el-form-item label="数据库连接密码" prop="jdbcPassword">
                            <el-input v-model="form.jdbcPassword" size="small" :disabled="isDetail"></el-input>
                        </el-form-item>
                    </el-col>	
                    <el-col :span="12">
                        <el-form-item label="数据库驱动类" prop="jdbcDriverClassName">
                            <el-input v-model="form.jdbcDriverClassName" size="small" :disabled="isDetail"></el-input>
                        </el-form-item>
                    </el-col>	
            	</el-row>
            	<el-row :gutter="24">
                    <el-col :span="12">
                        <el-form-item label="数据库schema" prop="jdbcSchema">
                            <el-input v-model="form.jdbcSchema" size="small" :disabled="isDetail"></el-input>
                        </el-form-item>
                    </el-col>	
                    <el-col :span="12">
                        <el-form-item label="java代码存放的路径" prop="javaPath">
                            <el-input v-model="form.javaPath" size="small" :disabled="isDetail"></el-input>
                        </el-form-item>
                    </el-col>	
            	</el-row>
            	<el-row :gutter="24">
                    <el-col :span="12">
                        <el-form-item label="资源文件存放的路径" prop="resourcesPath">
                            <el-input v-model="form.resourcesPath" size="small" :disabled="isDetail"></el-input>
                        </el-form-item>
                    </el-col>	
                    <el-col :span="12">
                        <el-form-item label="模板存放的路径" prop="templateFilePath">
                            <el-input v-model="form.templateFilePath" size="small" :disabled="isDetail"></el-input>
                        </el-form-item>
                    </el-col>	
            	</el-row>
            	<el-row :gutter="24">
                    <el-col :span="12">
                        <el-form-item label="基础包名" prop="baseModel">
                            <el-input v-model="form.baseModel" size="small" :disabled="isDetail"></el-input>
                        </el-form-item>
                    </el-col>	
                    <el-col :span="12">
                        <el-form-item label="基础包类路径" prop="basePackage">
                            <el-input v-model="form.basePackage" size="small" :disabled="isDetail"></el-input>
                        </el-form-item>
                    </el-col>	
            	</el-row>
            	<el-row :gutter="24">
                    <el-col :span="12">
                        <el-form-item label="model类路径" prop="modelPackage">
                            <el-input v-model="form.modelPackage" size="small" :disabled="isDetail"></el-input>
                        </el-form-item>
                    </el-col>	
                    <el-col :span="12">
                        <el-form-item label="mapper类路径" prop="mapperPackage">
                            <el-input v-model="form.mapperPackage" size="small" :disabled="isDetail"></el-input>
                        </el-form-item>
                    </el-col>	
            	</el-row>
            	<el-row :gutter="24">
                    <el-col :span="12">
                        <el-form-item label="service类路径" prop="servicePackage">
                            <el-input v-model="form.servicePackage" size="small" :disabled="isDetail"></el-input>
                        </el-form-item>
                    </el-col>	
                    <el-col :span="12">
                        <el-form-item label="service实Impl类路径" prop="serviceImplPackage">
                            <el-input v-model="form.serviceImplPackage" size="small" :disabled="isDetail"></el-input>
                        </el-form-item>
                    </el-col>	
            	</el-row>
            	<el-row :gutter="24">
                    <el-col :span="12">
                        <el-form-item label="controller类路径" prop="controllerPackage">
                            <el-input v-model="form.controllerPackage" size="small" :disabled="isDetail"></el-input>
                        </el-form-item>
                    </el-col>	
                    <el-col :span="12">
                        <el-form-item label="作者" prop="author">
                            <el-input v-model="form.author" size="small" :disabled="isDetail"></el-input>
                        </el-form-item>
                    </el-col>	
            	</el-row>
            	<el-row :gutter="24">
                    <el-col :span="12">
                        <el-form-item label="时间格式化" prop="dateFormat">
                            <el-input v-model="form.dateFormat" size="small" :disabled="isDetail"></el-input>
                        </el-form-item>
                    </el-col>	
                    <el-col :span="12">
                        <el-form-item label="执行次数" prop="runCount">
                            <el-input v-model="form.runCount" size="small" :disabled="isDetail"></el-input>
                        </el-form-item>
                    </el-col>	
            	</el-row>
            	<el-row :gutter="24">
                    <el-col :span="12">
                        <el-form-item label="执行类" prop="runClass">
                            <el-input v-model="form.runClass" size="small" :disabled="isDetail"></el-input>
                        </el-form-item>
                    </el-col>	
            		<el-col :span="12">
                        <el-form-item label="执行时间" prop="runTime">
			                <el-date-picker v-model="form.runTime" type="date" placeholder="选择日期" size="small" :disabled="isDetail"></el-date-picker>
			            </el-form-item>
                    </el-col>
            	</el-row>
            </el-form>
        </div>
        
        <div class="button-container">
            <el-row justify="center">
                <el-col :span="2" :offset="5">
                    <el-button type="primary" icon="el-icon-s-order" @click="saveOrUpdate" v-if="!isDetail">保存</el-button>
                </el-col>
                <el-col :span="2" :offset="2">
                    <el-button type="primary" icon="el-icon-delete-solid" @click="resetForm" v-if="!isDetail">重置</el-button>
                </el-col>
                <el-col :span="2" :offset="2">
                    <el-button type="primary" icon="el-icon-circle-close" @click="close" :offset="!isDetail?2:9">关闭</el-button>
                </el-col>
            </el-row>
        </div>
    </div>
</template>
<script>
import {genApi} from "@/service/sys-api";
export default {
    data(){
        return {
            form:{
            	id:'',
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
        	type:'detail',//处理类型，新增add、修改update、查看详情detail
            isDetail:false,
            rules: {//校验表单
            	id:[{required:true,message:'不能为空',trigger: 'blur'}],
            	runTable:[{required:true,message:'执行的表不能为空',trigger: 'blur'}],
            	jdbcUrl:[{required:true,message:'数据库连接URL不能为空',trigger: 'blur'}],
            	jdbcUsername:[{required:true,message:'数据库连接用户名不能为空',trigger: 'blur'}],
            	jdbcPassword:[{required:true,message:'数据库连接密码不能为空',trigger: 'blur'}],
            	jdbcDriverClassName:[{required:true,message:'数据库驱动类不能为空',trigger: 'blur'}],
            	jdbcSchema:[{required:true,message:'数据库schema不能为空',trigger: 'blur'}],
            	javaPath:[{required:true,message:'java代码存放的路径不能为空',trigger: 'blur'}],
            	resourcesPath:[{required:true,message:'资源文件存放的路径不能为空',trigger: 'blur'}],
            	templateFilePath:[{required:true,message:'模板存放的路径不能为空',trigger: 'blur'}],
            	baseModel:[{required:true,message:'基础包名不能为空',trigger: 'blur'}],
            	basePackage:[{required:true,message:'基础包类路径不能为空',trigger: 'blur'}],
            	modelPackage:[{required:true,message:'model类路径不能为空',trigger: 'blur'}],
            	mapperPackage:[{required:true,message:'mapper类路径不能为空',trigger: 'blur'}],
            	servicePackage:[{required:true,message:'service类路径不能为空',trigger: 'blur'}],
            	serviceImplPackage:[{required:true,message:'service实Impl类路径不能为空',trigger: 'blur'}],
            	controllerPackage:[{required:true,message:'controller类路径不能为空',trigger: 'blur'}],
            	author:[{required:true,message:'作者不能为空',trigger: 'blur'}],
            	dateFormat:[{required:true,message:'时间格式化不能为空',trigger: 'blur'}],
            	runCount:[{required:true,message:'执行次数不能为空',trigger: 'blur'}],
            	runClass:[{required:true,message:'执行类不能为空',trigger: 'blur'}],
            	runTime:[{required:true,message:'执行时间不能为空',trigger: 'blur'}],
            }
        }
    },
    props:{
    	checkrow:{
    		default: ()=>{
    			return '';
    		}
    	}
    },
    components:{
    
    },
    mounted(){
 		this.queryById();
    },
    methods:{
        //重置
        resetForm() {
            this.$refs["form"].resetFields();
        },
        //关闭
        close() {
            this.$emit('closechild');
        },
        //根据ID查询记录
        queryById(){
            this.type= this.checkrow.type;
            let selObj = this.checkrow.selArr;
            if(this.type == 'detail'){
                this.isDetail = true;
            }

            if(this.type=='update'||this.type=='detail'){
                let id = selObj.ID;
                let param = new URLSearchParams();
                param.append("id",id);
                
                //let param = {
                //    ID:id
                //};
                genApi.detail(param).then((res)=>{
                    if(res.code == "0"){
                        this.form = res.data;
                    }else{
                        this.$alert('获取信息失败，请联系管理员处理','提示信息');
                    }
                });
            }
            
        },

        //新增或者更新
        saveOrUpdate() {
        this.$refs['form'].validate((valid) =>{
                if(valid){
		        	let param = this.form;
		            let loading = this.$loading({lock:true,text:'保存中....',background:'rgba(0,0,0,0.5)'});
		            let url = '';
		            if(this.type == 'update'){
		                genApi.update(param).then((res)=>{
			    			if(res.code == "0"){
			        			this.$alert('更新成功','提示信息',{
			        				confirmButtonText:'确定',
			        				callback: action => {
			        					this.$emit('closechild');
			        				}
			        			})
			        		}else{
			        			this.$alert('提交失败，请联系管理员处理','提示信息');
			        		}
			        		loading.close();
			        	});	
		            }else{
		                genApi.save(param).then((res)=>{
			    			if(res.code == "0"){
			        			this.$alert('保存成功','提示信息',{
			        				confirmButtonText:'确定',
			        				callback: action => {
			        					this.$emit('closechild');
			        				}
			        			})
			        		}else{
			        			this.$alert('提交失败，请联系管理员处理','提示信息');
			        		}
			        		loading.close();
			        	});	
		            }
		        }
            })
        },
    }
}
</script>
<style lang="scss" scoped>
@import 'src/components/page/style/normal'; 
</style>