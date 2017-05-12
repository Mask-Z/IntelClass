package com.aixuexiao.test;

import com.aixuexiao.dao.StudentDao;
import com.aixuexiao.model.Student;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Administrator on 2017/5/10 0010.
 */
@Service
public class AccessDataBase {
//    @Resource(name = "studentDao")
//    private  StudentDao studentDao;

    public static void main(String[] args) {
        StudentDao studentDao = new StudentDao();
        List<Student> list = studentDao.findStudentByClassesId(301);
        for (int i = 0; i < list.size(); i++)
            System.out.println(list.get(i).getName());
    }

}
