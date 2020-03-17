<template>
  <div class="idea">
    <div class="">
      <div>{{ idea.content }}</div>
      <div v-for="comment in idea.comments" :key="comment.id" class="card card-body mb-3">
        <div>{{comment.content}}</div>
        <div v-if='(user_id==comment.user_id)' @click="destroy(comment, $event)" type="button"><i class="fa fa-trash-o" aria-hidden="true"></i></div>
      </div>

      <div class="comment_form">
        <a v-if="!editing" v-on:click="startEditing"><i class="fa fa-plus-circle" aria-hidden="true"></i>コメントを追加</a>
        <textarea v-if="editing" ref="message" v-model="message" class="form-control mb-1 content_form"></textarea>
        <button v-if="editing" v-on:click="submitMessage" class="btn btn-secondary">コメントを追加</button>
        <a v-if="editing" v-on:click="editing=false">キャンセル</a>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: ['idea'],
  data: function() {
    return{
      editing: false,
      message: "",
      user_id: sharedData.user_id,
    }
  },

  methods: {
    startEditing: function() {
      this.editing = true
      this.$nextTick(() => { this.$refs.message.focus() }) //コメント追加時にフォームを入力状態にする
    },

    // コメントの新規作成
    submitMessage: function() {
      var data = new FormData
      data.append("comment[idea_id]", this.idea.id)
      data.append("comment[content]", this.message)

      Rails.ajax({
        url: `/ideas/${this.idea.id}/comment`,
        type: "POST",
        data: data,
        dataType: "json",
        beforeSend: function() { return true },
        success: (data) => {
          const index = window.store.ideas.findIndex(item => item.id == this.idea.id)
          window.store.ideas[index].comments.push(data)
          this.message = ""
          this.$nextTick(() => { this.$refs.message.focus() }) //コメント追加時に次のフォームを入力状態にする
        }
      })
    },

    // コメント削除機能
    destroy: function (comment) {
      var data = new FormData
      data.append("comment[content]", comment.content)
      Rails.ajax({
        url: `/comments/${comment.id}`,
        type: "DELETE",
        data: data,
        dataType: "json",
        success: (data) => {
          const idea_index = window.store.ideas.findIndex((item) => item.id == this.idea.id)
          const comment_index = window.store.ideas[idea_index].comments.findIndex((item) => item.id == comment.id)
          window.store.ideas[idea_index].comments.splice(comment_index, 1)

          this.editing = false
        }
      })
    },


  }
  
}
</script>



<style lang="scss" scoped>



</style>