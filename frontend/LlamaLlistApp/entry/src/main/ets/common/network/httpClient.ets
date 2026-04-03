import http from '@ohos.net.http';

// 替换为你的电脑局域网 IP（如 192.168.1.100）
const BASE_URL = 'http://10.0.2.2:8000';

export async function request<T>(url: string, method: string, data?: object): Promise<T> {
  const httpRequest = http.createHttp();
  const options: http.HttpRequestOptions = {
    method: method as http.RequestMethod,
    header: { 'Content-Type': 'application/json' },
    extraData: data ? JSON.stringify(data) : undefined,
    connectTimeout: 60000,
    readTimeout: 60000,
  };
  try {
    const response = await httpRequest.request(`${BASE_URL}${url}`, options);
    if (response.responseCode >= 200 && response.responseCode < 300) {
      return JSON.parse(response.result as string) as T;
    } else {
      throw new Error(`HTTP ${response.responseCode}`);
    }
  } catch (err) {
    console.error('请求失败', JSON.stringify(err));
    if (err instanceof Error) {
      throw err;
    } else {
      throw new Error(JSON.stringify(err));
    }
  } finally {
    httpRequest.destroy();
  }
}