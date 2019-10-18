<template>
    <div id="itemManager-container">
        <div class="form-container">
            <el-form ref="form" :rules="rules" :model="form" label-width="100px">
            	            	<el-row :gutter="24">
                    <el-col :span="12">
                        <el-form-item label="用户名" prop="username">
                            <el-input v-model="form.username" size="small" :disabled="isDetail"></el-input>
                        </el-form-item>
                    </el-col>	
            	</el-row>
            	<el-row :gutter="24">
                    <el-col :span="12">
                        <el-form-item label="密码" prop="password">
                            <el-input v-model="form.password" size="small" :disabled="isDetail"></el-input>
                        </el-form-item>
                    </el-col>	
                    <el-col :span="12">
                        <el-form-item label="盐" prop="salt">
                            <el-input v-model="form.salt" size="small" :disabled="isDetail"></el-input>
                        </el-form-item>
                    </el-col>	
            	</el-row>
            	<el-row :gutter="24">
                    <el-col :span="12">
                        <el-form-item label="邮箱" prop="email">
                            <el-input v-model="form.email" size="small" :disabled="isDetail"></el-input>
                        </el-form-item>
                    </el-col>	
                    <el-col :span="12">
                        <el-form-item label="手机号码" prop="mobile">
                            <el-input v-model="form.mobile" size="small" :disabled="isDetail"></el-input>
                        </el-form-item>
                    </el-col>	
            	</el-row>
            	<el-row :gutter="24">
                    <el-col :span="12">
                    	<el-form-item label="状态 0：禁用  1：启用" prop="status">
                            <el-select v-model="form.status" placeholder="请选择" style="width:100%" size="small" :disabled="isDetail">
                                <el-option
                                    v-for="it in statusArr"
                                    :key="it.value"
                                    :label="it.label"
                                    :value="it.value">
                                </el-option>
                            </el-select>
                        </el-form-item>
                    </el-col>
                    <el-col :span="12">
                        <el-form-item label="部门id" prop="deptId">
                            <el-input v-model="form.deptId" size="small" :disabled="isDetail"></el-input>
                        </el-form-item>
                    </el-col>	
            	</el-row>
            	<el-row :gutter="24">
                    <el-col :span="12">
                        <el-form-item label="名称" prop="name">
                            <el-input v-model="form.name" size="small" :disabled="isDetail"></el-input>
                        </el-form-item>
                    </el-col>	
            		<el-col :span="12">
                        <el-form-item label="创建时间" prop="createTime">
			                <el-date-picker v-model="form.createTime" type="date" placeholder="选择日期" size="small" :disabled="isDetail"></el-date-picker>
			            </el-form-item>
                    </el-col>
            	</el-row>
            	<el-row :gutter="24">
                    <el-col :span="12">
                        <el-form-item label="用户代码" prop="userCode">
                            <el-input v-model="form.userCode" size="small" :disabled="isDetail"></el-input>
                        </el-form-item>
                    </el-col>	
                    <el-col :span="12">
                        <el-form-item label="用户类型" prop="userType">
                            <el-input v-model="form.userType" size="small" :disabled="isDetail"></el-input>
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
import {userApi} from "@/service/sys-api";
export default {
    data(){
        return {
            form:{
            	userId:'',
            	username:'',
            	password:'',
            	salt:'',
            	email:'',
            	mobile:'',
            	status:'',
            	deptId:'',
            	name:'',
            	createTime:'',
            	userCode:'',
            	userType:'',
            },
            statusArr:[],
        	type:'detail',//处理类型，新增add、修改update、查看详情detail
            isDetail:false,
            rules: {//校验表单
            	userId:[{required:true,message:'用户ID不能为空',trigger: 'blur'}],
            	username:[{required:true,message:'用户名不能为空',trigger: 'blur'}],
            	password:[{required:true,message:'密码不能为空',trigger: 'blur'}],
            	salt:[{required:true,message:'盐不能为空',trigger: 'blur'}],
            	email:[{required:true,message:'邮箱不能为空',trigger: 'blur'}],
            	mobile:[{required:true,message:'手机号码不能为空',trigger: 'blur'}],
            	status:[{required:true,message:'状态 0：禁用  1：启用不能为空',trigger: 'blur'}],
            	deptId:[{required:true,message:'部门id不能为空',trigger: 'blur'}],
            	name:[{required:true,message:'名称不能为空',trigger: 'blur'}],
            	createTime:[{required:true,message:'创建时间不能为空',trigger: 'blur'}],
            	userCode:[{required:true,message:'用户代码不能为空',trigger: 'blur'}],
            	userType:[{required:true,message:'用户类型不能为空',trigger: 'blur'}],
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
                let id = selObj.user_id;
                let param = new URLSearchParams();
                param.append("id",id);
                //let param = {
                //    user_id:id
                //};
                userApi.detail(param).then((res)=>{
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
		                userApi.update(param).then((res)=>{
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
		                userApi.save(param).then((res)=>{
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