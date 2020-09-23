<template>
    <div id="itemManager-container">
        <div class="form-container">
            <el-form ref="form" :rules="rules" :model="form" label-width="100px">
            	<el-row :gutter="24">
                    <el-col :span="12">
                        <el-form-item label="标题" prop="title">
                            <el-input v-model="form.title" size="small" :disabled="isDetail"></el-input>
                        </el-form-item>
                    </el-col>	
            	</el-row>
            	<el-row :gutter="24">
                    <el-col :span="12">
                        <el-form-item label="副标题" prop="subTitle">
                            <el-input v-model="form.subTitle" size="small" :disabled="isDetail"></el-input>
                        </el-form-item>
                    </el-col>	
                    <el-col :span="12">
                        <el-form-item label="文章内容" prop="content">
                            <el-input v-model="form.content" size="small" :disabled="isDetail"></el-input>
                        </el-form-item>
                    </el-col>	
            	</el-row>
            	<el-row :gutter="24">
                    <el-col :span="12">
                        <el-form-item label="作者" prop="author">
                            <el-input v-model="form.author" size="small" :disabled="isDetail"></el-input>
                        </el-form-item>
                    </el-col>	
                    <el-col :span="12">
                        <el-form-item label="查看次数" prop="readCount">
                            <el-input v-model="form.readCount" size="small" :disabled="isDetail"></el-input>
                        </el-form-item>
                    </el-col>	
            	</el-row>
            	<el-row :gutter="24">
                    <el-col :span="12">
                        <el-form-item label="点赞次数" prop="zanCount">
                            <el-input v-model="form.zanCount" size="small" :disabled="isDetail"></el-input>
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
                        <el-form-item label="更新时间" prop="updateTime">
			                <el-date-picker v-model="form.updateTime" type="date" placeholder="选择日期" size="small" :disabled="isDetail"></el-date-picker>
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
import {articleApi} from "@/service/sys-api";
export default {
    data(){
        return {
            form:{
            	id:'',
            	title:'',
            	subTitle:'',
            	content:'',
            	author:'',
            	readCount:'',
            	zanCount:'',
            	createTime:'',
            	updateTime:'',
            },
        	type:'detail',//处理类型，新增add、修改update、查看详情detail
            isDetail:false,
            rules: {//校验表单
            	id:[{required:true,message:'id不能为空',trigger: 'blur'}],
            	title:[{required:true,message:'标题不能为空',trigger: 'blur'}],
            	subTitle:[{required:true,message:'副标题不能为空',trigger: 'blur'}],
            	content:[{required:true,message:'文章内容不能为空',trigger: 'blur'}],
            	author:[{required:true,message:'作者不能为空',trigger: 'blur'}],
            	readCount:[{required:true,message:'查看次数不能为空',trigger: 'blur'}],
            	zanCount:[{required:true,message:'点赞次数不能为空',trigger: 'blur'}],
            	createTime:[{required:true,message:'创建时间不能为空',trigger: 'blur'}],
            	updateTime:[{required:true,message:'更新时间不能为空',trigger: 'blur'}],
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
                let id = selObj.id;
                let param = new URLSearchParams();
                param.append("id",id);
                //let param = {
                //    id:id
                //};
                articleApi.detail(param).then((res)=>{
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
		                articleApi.update(param).then((res)=>{
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
		                articleApi.save(param).then((res)=>{
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