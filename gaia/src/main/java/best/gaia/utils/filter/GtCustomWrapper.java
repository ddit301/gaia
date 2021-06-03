package best.gaia.utils.filter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

public final class GtCustomWrapper extends HttpServletRequestWrapper {
 
 public GtCustomWrapper(HttpServletRequest servletRequest){
  super(servletRequest);
 }
 
 public String[] getParameterValues(String parameter){
  
  String[] values = super.getParameterValues(parameter);
  
  if(values == null){
   return null;
  }
  int count = values.length;
  
  String[] encodedValues = new String[count];
  for(int i = 0; i < count; i++){
   encodedValues[i] = XssFilterMethod(values[i]);
  }
  
  return encodedValues;
 }
 
 public String getParameter(String parameter){
  String value = super.getParameter(parameter);
  if(value == null){
   return null;
  }
  return XssFilterMethod(value);
 }
 
 public String getHeader(String name){
  String value = super.getHeader(name);
  if(value == null){
   return null;
  }
  return XssFilterMethod(value);
 }
 
 private String XssFilterMethod(String value){
  
  value = value.replaceAll("&gt;",">");
  
  return value;
 }
}



