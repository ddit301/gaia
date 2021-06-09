package best.gaia.utils;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import org.apache.http.HttpHost;
import org.elasticsearch.action.get.GetRequest;
import org.elasticsearch.action.get.GetResponse;
import org.elasticsearch.action.index.IndexRequest;
import org.elasticsearch.action.index.IndexResponse;
import org.elasticsearch.action.search.SearchRequest;
import org.elasticsearch.action.search.SearchResponse;
import org.elasticsearch.client.RequestOptions;
import org.elasticsearch.client.RestClient;
import org.elasticsearch.client.RestClientBuilder;
import org.elasticsearch.client.RestHighLevelClient;
import org.elasticsearch.common.Strings;
import org.elasticsearch.common.xcontent.XContentBuilder;
import org.elasticsearch.common.xcontent.XContentFactory;
import org.elasticsearch.common.xcontent.XContentType;
import org.elasticsearch.index.query.QueryBuilders;
import org.elasticsearch.search.SearchHit;
import org.elasticsearch.search.SearchHits;
import org.elasticsearch.search.builder.SearchSourceBuilder;
import org.elasticsearch.search.sort.FieldSortBuilder;
import org.elasticsearch.search.sort.SortOrder;
import org.springframework.stereotype.Component;

import com.ibatis.common.resources.Resources;

@Component
public class ElasticUtil {
	private RestClientBuilder restClientBuilder;
	
	private ElasticUtil() {
        Properties properties = new Properties();
		try {	// dbinfo.properties에서 접속 정보 받아옵니다.
			properties.load(Resources.getResourceAsReader("best/gaia/db/dbinfo.properties"));
		} catch (IOException e) {}
        String hostname = properties.getProperty("el.url");
        int port = Integer.parseInt(properties.getProperty("el.port"));
        HttpHost host = new HttpHost(hostname, port);
        restClientBuilder = RestClient.builder(host);
	};
	
	public List<Map<String,Object>> simpleSearch(
			String index
			, Map<String,Object> query
			, Map<String,SortOrder> sort
			){
		/*
		 * search API 참고 주소
		 * https://www.elastic.co/guide/en/elasticsearch/client/java-rest/master/java-rest-high-search.html
		 */
		
		// search에 index 조건 걸기
		SearchRequest searchRequest = new SearchRequest(index);
		SearchSourceBuilder searchSourceBuilder = new SearchSourceBuilder();
		
		// query에 있는 셋 쿼리 조건으로 걸기
		for(String key : query.keySet()) {
			searchSourceBuilder.query(QueryBuilders.matchQuery(key, query.get(key)));
		}
		
		// sort 에 있는 셋을 정렬 조건으로 걸기
		for(String key : sort.keySet()) {
			searchSourceBuilder.sort(new FieldSortBuilder(key).order(sort.get(key)));
		}
		
		searchRequest.source(searchSourceBuilder);
		
		List<Map<String,Object>> list = new ArrayList<>();
		try(RestHighLevelClient client = new RestHighLevelClient(restClientBuilder)) {
			SearchResponse response = client.search(searchRequest, RequestOptions.DEFAULT);
			SearchHits searchHits = response.getHits();
			for(SearchHit hit : searchHits) {
				Map<String, Object> sourceMap = hit.getSourceAsMap();
				list.add(sourceMap);
			}
		} catch (IOException e) {}
		
		return list;
		
	}
	
	public Map<String,Object> getReponse(String index, String id){
		
		GetResponse response = null; 
		
		GetRequest getRequest = new GetRequest(index, id);
		RequestOptions options = RequestOptions.DEFAULT;
		try (RestHighLevelClient client = new RestHighLevelClient(restClientBuilder)) {
			response = client.get(getRequest, options);
		} catch (IOException e) {}
		
		return response.getSourceAsMap();
	}
	
	public int insert(String index, String id, Map<String, Object> data ){
		IndexResponse response = null;
		try(RestHighLevelClient client = new RestHighLevelClient(restClientBuilder)) {
			data.put("date", LocalDateTime.now());
			XContentBuilder xContent = XContentFactory.jsonBuilder().map(data);
			String jsonBody = Strings.toString(xContent);
			
			IndexRequest indexRequest = new IndexRequest(index).id(id).source(jsonBody, XContentType.JSON);
			response = client.index(indexRequest, RequestOptions.DEFAULT);
		} catch (IOException e) {}
		
		return response.getShardInfo().getSuccessful();
	}

}