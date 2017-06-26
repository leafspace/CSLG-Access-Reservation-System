package cn.edu.cslg.process;

/**
 * Created by Administrator on 2017/6/26.
 */
import cn.edu.cslg.bean.ReceiveXmlEntity;
import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.Iterator;



/**
 * 解析接收到的微信xml，返回消息对象
 * @author pamchen-1
 *
 */
public class ReceiveXmlProcess {
    /**
     * 解析微信xml消息
     * @param strXml
     * @return
     */
    public ReceiveXmlEntity getMsgEntity(String strXml){
        ReceiveXmlEntity msg = null;
        try {
            if (strXml.length() <= 0 || strXml == null)
                return null;

            // 将字符串转化为XML文档对象
            Document document = DocumentHelper.parseText(strXml);
            // 获得文档的根节点
            Element root = document.getRootElement();
            // 遍历根节点下所有子节点
            Iterator<?> iter = root.elementIterator();

            // 遍历所有结点
            msg = new ReceiveXmlEntity();
            //利用反射机制，调用set方法
            //获取该实体的元类型
            Class<?> c = Class.forName("demo.entity.ReceiveXmlEntity");
            msg = (ReceiveXmlEntity)c.newInstance();//创建这个实体的对象

            while(iter.hasNext()){
                Element ele = (Element)iter.next();
                //获取set方法中的参数字段（实体类的属性）
                Field field = c.getDeclaredField(ele.getName());
                //获取set方法，field.getType())获取它的参数数据类型
                Method method = c.getDeclaredMethod("set"+ele.getName(), field.getType());
                //调用set方法
                method.invoke(msg, ele.getText());
            }
        } catch (Exception e) {
            // TODO: handle exception
            System.out.println("xml 格式异常: "+ strXml);
            e.printStackTrace();
        }
        return msg;
    }
}