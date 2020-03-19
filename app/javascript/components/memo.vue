<template>
<!-- メモ編集フォーム (モーダルウインドウ)-->
  <div>
    <div class="card card-body mb-3" >
      <div @click="editing=true">{{ memo.content }}</div>
    </div> 
    <div v-if='editing' class="modal-backdrop show"></div>

    <div v-if='editing' @click="closeModal" class="modal show" style="display: block">
      <div class="modal-dialog">
        <div class="modal-content">
          <div draggable="true" class="modal-body">
            <textarea v-model="content" class="form-control content_form"></textarea>
          </div>
          <div class="modal-footer">
            <button @click="save" type="button" class="btn btn-primary">保存</button>
            <button @click="destroy" type="button" class="btn btn-primary">削除</button>
            <button @click="changeIdea" type="button" class="btn btn-primary">アイディアへ移行</button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>


<script>
export default {
  props: ['memo', 'idea'],
  data: function() {
    return {
      editing: false,
      content: this.memo.content,
    }
  },

  methods: {
    // メモ(content)編集（モーダル）
    closeModal: function(event) {
      if (event.target.classList.contains("modal")) { this.editing = false }
    },

    save: function() {
      var data = new FormData
      data.append("memo[content]", this.content)

      Rails.ajax({
        url: `/memos/${this.memo.id}`,
        type: "PATCH",
        data: data,
        dataType: "json",
        success: (data) => {
          const idea_index = window.store.ideas.findIndex((item) => item.id == this.idea.id)
          const memo_index = window.store.ideas[idea_index].memos.findIndex((item) => item.id == this.memo.id)
          window.store.ideas[idea_index].memos.splice(memo_index, 1, data)

          this.editing = false
        }
      })
    },
    // メモ削除
    destroy: function() {
      var data = new FormData
      data.append("memo[content]", this.content)
      Rails.ajax({
        url: `/memos/${this.memo.id}`,
        type: "DELETE",
        data: data,
        dataType: "json",
        success: (data) => {
          const idea_index = window.store.ideas.findIndex((item) => item.id == this.idea.id)
          const memo_index = window.store.ideas[idea_index].memos.findIndex((item) => item.id == this.memo.id)
          window.store.ideas[idea_index].memos.splice(memo_index, 1)

          this.editing = false
        }
      })
    },

    // メモをアイディアに移動
    changeIdea: function() {
      console.log("a")
    
      // メモの削除
      var data = new FormData
      data.append("memo[content]", this.content)

      Rails.ajax({
        url: `/memos/${this.memo.id}`,
        type: "DELETE",
        data: data,
        dataType: "json",
        success: (data) => {
          const idea_index = window.store.ideas.findIndex((item) => item.id == this.idea.id)
          const memo_index = window.store.ideas[idea_index].memos.findIndex((item) => item.id == this.memo.id)
          window.store.ideas[idea_index].memos.splice(memo_index, 1)

          this.editing = false
        }
      })

      // メモのcontentをアイディアのcontentとして追加
      var data = new FormData
      data.append("idea[content]", this.content)

      Rails.ajax({
        url: "/ideas",
        type: "POST",
        data: data,
        dataType: "json",
        beforeSend: function() { return true },
        success: (data) => {
          window.store.ideas.push(data)
          this.message = ""
          this.editing = false
        }
      })
    },

  }
}
</script>

<style lang="scss" scoped>

.card-body{
  padding: 10px;
}
</style>