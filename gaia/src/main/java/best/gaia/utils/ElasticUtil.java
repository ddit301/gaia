package best.gaia.utils;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.Map;
import java.util.Properties;

import org.apache.http.HttpHost;
import org.elasticsearch.action.get.GetRequest;
import org.elasticsearch.action.get.GetResponse;
import org.elasticsearch.action.index.IndexRequest;
import org.elasticsearch.action.index.IndexResponse;
import org.elasticsearch.client.RequestOptions;
import org.elasticsearch.client.RestClient;
import org.elasticsearch.client.RestClientBuilder;
import org.elasticsearch.client.RestHighLevelClient;
import org.elasticsearch.common.Strings;
import org.elasticsearch.common.xcontent.XContentBuilder;
import org.elasticsearch.common.xcontent.XContentFactory;
import org.elasticsearch.common.xcontent.XContentType;

import com.ibatis.common.resources.Resources;


public class ElasticUtil {
	private static ElasticUtil self;
	private static RestHighLevelClient client;
	
	private ElasticUtil() {
        Properties properties = new Properties();
		try {
			properties.load(Resources.getResourceAsReader("best/gaia/db/dbinfo.properties"));
		} catch (IOException e) {}
        String hostname = properties.getProperty("el.url");
        int port = Integer.parseInt(properties.getProperty("el.port"));
        HttpHost host = new HttpHost(hostname, port);
        RestClientBuilder restClientBuilder = RestClient.builder(host);
        client = new RestHighLevelClient(restClientBuilder);
	};
	
	public static ElasticUtil getInstance() {
		if(self == null)
			self = new ElasticUtil();
		return self;
	}
	
	public Map<String,Object> getReponse(String index, String id){
		GetResponse response = null; 
		
		GetRequest getRequest = new GetRequest(index, id);
		RequestOptions options = RequestOptions.DEFAULT;
		try {
			response = client.get(getRequest, options);
		} catch (IOException e) {
		}
		
		return response.getSourceAsMap();
	}
	
	public int insert(String index, String id, Map<String, Object> data ){
		IndexResponse response = null;
		try {
			data.put("date", LocalDateTime.now());
			XContentBuilder xContent = XContentFactory.jsonBuilder().map(data);
			String jsonBody = Strings.toString(xContent);
			
			IndexRequest indexRequest = new IndexRequest(index).id(id).source(jsonBody, XContentType.JSON);
			response = client.index(indexRequest, RequestOptions.DEFAULT);
		} catch (IOException e) {}
		
		return response.getShardInfo().getSuccessful();
	}

}
