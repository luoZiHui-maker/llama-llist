import http from '@ohos.net.http';
import { AppConfig } from '../constants/Config';

const BASE_URL = AppConfig.BASE_URL;

export async function request<T>(url: string, method: string, data?: object): Promise<T> {
  const httpRequest = http.createHttp();
  const options: http.HttpRequestOptions = {
    method: method as http.RequestMethod,
    header: { 'Content-Type': 'application/json' },
    extraData: data ? JSON.stringify(data) : undefined,
    connectTimeout: AppConfig.CONNECT_TIMEOUT,
    readTimeout: AppConfig.READ_TIMEOUT,
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