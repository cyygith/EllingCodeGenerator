package com.elling.goods.service.impl;

import com.elling.goods.dao.mapper.SysUserMapper;
import com.elling.goods.model.SysUser;
import com.elling.goods.service.SysUserService;
import com.elling.common.base.AbstractService;
import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;

/**
 *
 * Created by cyy on 2019-10-18 10:55:22.
 */
@Service
public class SysUserServiceImpl extends AbstractService<SysUser> implements SysUserService {

    @Autowired
    private SysUserMapper sysUserMapper;

}
