// 应用全局配置
export class AppConfig {
  // 后端 API 基础地址（根据运行环境修改）
  // 使用模拟器专用的虚拟地址 http://10.0.2.2:8000 作为 BASE_URL，这样就不受电脑 IP 变化的影响
  static readonly BASE_URL: string = 'http://10.0.2.2:8000';

  // 请求超时时间（毫秒）
  static readonly CONNECT_TIMEOUT: number = 60000;
  static readonly READ_TIMEOUT: number = 60000;

  // 是否启用 Mock 模式（前端独立开发时使用）
  static readonly USE_MOCK: boolean = false;

  // API 版本
  static readonly API_VERSION: string = 'v1';
}