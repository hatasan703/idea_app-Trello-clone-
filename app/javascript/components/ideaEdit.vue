<template>
  <div class="idea_edit">
    <div class="idea_card">
      <div class="idea_title">{{ title }}</div>
      <div class="idea_action">
        <i @click="editing=true" class="fa fa-edit" aria-hidden="true"></i>
        <i @click="newsPage" class="fa fa-newspaper-o" aria-hidden="true"></i>
        <span class="count">
          <i class="fa fa-thumbs-up" aria-hidden="true"></i> {{ likeCount }}
          <i class="fa fa-commenting-o" aria-hidden="true"></i> {{ commentCount }}
        </span>
      </div>
      <div class="idea_content">{{ content }}</div>
      <p @click="planningNew" class="create_plan">プランニングへ</p>
    </div>
    <div v-if='editing' class="modal-backdrop show"></div>
    <div v-if='editing' @click="closeModal" class="modal show" style="display: block">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-body">
            <label for="">タイトル</label>
            <textarea v-model="title" class="form-control title_form"></textarea>
            <label for="">詳細</label>
            <textarea v-model="content" class="form-control content_form"></textarea>
          </div>
          <div class="modal-footer">
            <input type="checkbox" v-model="open" true-value=true false-value=false>
            <label for="open">公開　</label>
            <button @click="save" type="button" class="btn btn-primary">保存</button>
            <button @click="destroy" type="button" class="btn btn-primary">削除</button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>



<script>
export default {
  props: ['idea'],
  data: function() {
    return {
      editing: false,
      title: this.idea.title,
      content: this.idea.content,
      open: this.idea.open,
    }
  },

  computed: {
    // いいね数を返す
    likeCount() {
      if (this.idea.likes) {return this.idea.likes.length}
    },
    // コメント数を返す
    commentCount() {
      if (this.idea.comments) {return this.idea.comments.length}
    },
    // ログインユーザが既にいいねしているかを判定する
    isLiked() {
      if (this.likeList.length === 0) { return false }
      return Boolean(this.findLikeId())
    }
  },

  methods: {
    closeModal: function(event) {
      if (event.target.classList.contains("modal")) { this.editing = false }
    },

    // アイディア(content)編集（モーダル）
    save: function() {
      var data = new FormData
      data.append("idea[title]", this.title)
      data.append("idea[content]", this.content)
      data.append("idea[open]", this.open)


      Rails.ajax({
        beforeSend: () => true,
        url: `ideas/${this.idea.id}`,
        type: "PATCH",
        data: data,
        dataType: "json",
        success: (data) => {
          const idea_index = window.store.ideas.findIndex((item) => item.id == this.idea.id)
          window.store.ideas.splice(idea_index, 1, data)
          this.editing = false
        }
      })
    },
    
    // アイディア削除
     destroy: function() {
      var data = new FormData
      data.append("idea[content]", this.content)

      Rails.ajax({
        beforeSend: () => true,
        url: `/ideas/${this.idea.id}`,
        url: `/companies/${this.idea.company_id}/ideas/${this.idea.id}`,
        type: "DELETE",
        data: data,
        dataType: "json",
        success: (data) => {
          const idea_index = window.store.ideas.findIndex((item) => item.id == this.idea.id)
          window.store.ideas.splice(idea_index, 1)
          this.editing = false
        }
      })
    },

    // idea#show ニュースページ
    newsPage: function() {
      location.href = `/ideas/${this.idea.id}/news`
    },

    planningNew: function() {
      location.href = `/ideas/${this.idea.id}/plans/new`
    },
    

  }
}
</script>


<style lang="scss" scoped>

.idea_card{
  display: inline-block;
  min-width: 230px;
  padding: 10px;
}

.idea_title{
  font-weight: bold;
  font-size: 15px;
}

.idea_content{
  font-size: 13px;
}

.count{
margin-left: 80px;
}

.content_form{
  height: 300px;
}

.create_plan{
  font-size: 15px;
  color: #007bff;
  cursor: pointer;
}

.create_plan:hover{
  opacity: 0.5;  
}

</style>