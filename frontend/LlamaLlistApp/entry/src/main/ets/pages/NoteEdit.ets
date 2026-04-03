import { request } from '../common/network/httpClient';
import router from '@ohos.router';
import promptAction from '@ohos.promptAction';

interface NoteCreateRequest {
  title: string;
  content: string;
}

interface NoteResponse {
  id: number;
  title: string;
  content: string;
  created_at: string;
  updated_at: string;
}

@Entry
@Component
struct NoteEdit {
  @State title: string = '';
  @State content: string = '';
  @State isSaving: boolean = false;

  build() {
    Column() {
      // 顶部栏
      Row() {
        Button('取消')
          .onClick(() => {
            router.back();
          })
        Blank()
        Text('新建笔记')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
        Blank()
        Button('保存')
          .onClick(() => {
            this.saveNote();
          })
          .enabled(!this.isSaving)
      }
      .width('100%')
      .padding(16)

      // 输入区域
      Scroll() {
        Column({ space: 16 }) {
          TextInput({ placeholder: '标题（必填）', text: this.title })
            .onChange((value: string) => {
              this.title = value;
            })
            .maxLength(200)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)

          TextArea({ placeholder: '内容（可选）', text: this.content })
            .onChange((value: string) => {
              this.content = value;
            })
            .height(200)
            .fontSize(16)
        }
        .padding(16)
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFF')
  }

  async saveNote() {
    console.info('saveNote 被调用');
    if (!this.title.trim()) {
      promptAction.showToast({ message: '标题不能为空' });
      return;
    }

    this.isSaving = true;
    try {
      const result = await request<NoteResponse>('/notes/', 'POST', {
        title: this.title.trim(),
        content: this.content || ''
      } as NoteCreateRequest);
      promptAction.showToast({ message: '保存成功' });
      router.back();
    } catch (e) {
      promptAction.showToast({ message: '保存失败，请检查网络' });
      console.error('保存失败', JSON.stringify(e));
    } finally {
      this.isSaving = false;
    }
  }
}