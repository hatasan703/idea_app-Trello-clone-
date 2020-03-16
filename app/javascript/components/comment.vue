<template>
  <div>
    <div class="idea idea_content">
      <div>{{ idea.content }}</div>
      <div v-for="comment in idea.comments" :key="comment.id" class="card card-body mb-3">
        {{comment.content}}
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
  props: ["idea"],
  data: function() {
    return{
      // ideas: this.comment_ideas,
      editing: false,
      message: "",
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

  }
  
}
</script>



<style>

</style>