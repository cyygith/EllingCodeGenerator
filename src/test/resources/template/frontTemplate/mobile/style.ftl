/**head and foot***/
.head-panel{
    background: lightblue;
    padding: 0.7rem 1.2rem 0.7rem 0.7rem;
    letter-spacing: 1rem;
    /* position: absolute;
    top:0;
    left:0;
    right:0;
    height:5%; */
}
    .btnclass{
        background-color: rgb(140, 205, 224);
        color: white;
        border: 0px;    
        padding: 0.5rem 0.5rem;
    }
    .head-back{
        letter-spacing: 0.2rem;
    }
    .head-save{
        float: right;
        letter-spacing: 0.3rem;
        margin-right: 0.2rem;
    }
    .foot-panel{
        padding: 0.3rem;
    }
.content-panel{
    /* position: absolute;
    top:10%;
    left:0;
    bottom:0;
    overflow: scroll; */
}
/**normal item*****/
.c-item{
    border-bottom: 1px solid rgb(207, 206, 206);
    padding: 0.7rem 0.7rem 1.2rem 1rem;
}
.c-input{
    width: 88%;
    height:2rem;
}
.c-input-7{
    width: 70%;
    height:2rem;
}
.c-textarea{
    width: 90%;
    margin-bottom: 1rem;
    padding-bottom: 1rem;
}
/**--两种状态**/
.c-status{
    margin-top: 1rem;
}
    .cc-empty{
        padding: 0.7rem;
        background: rgb(207, 204, 204);
        color: grey;
    }
    .cc-use{
        padding: 0.7rem;
        background: rgb(83, 155, 179);
        margin-left: -0.3rem;
    }
/**--椭圆形标识符***/
.c-group{
    padding: 0.7rem;
    line-height: 2.5rem;
}
    .c-g-item{
        padding: 0rem 0.5rem;
        background: rgb(207, 204, 204);
        color: grey;
        border-radius: 1rem;
        margin-right: 1rem;
        display: inline-block;
        line-height: 1.8rem;
    }
    .c-g-item-this{
        background-color: rgb(144, 173, 236);
        color: white;
    }
/*******以下是头尾固定，中间滚动的样式***************/
.fixed-head{
    background-color: #75c2ee;
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    height: 5%;
}
.overflow-content{
    position: absolute;
    left: 0;
    right: 0;
    top: 9%;
    bottom: 8%;
    overflow: auto;
    padding: 0
}