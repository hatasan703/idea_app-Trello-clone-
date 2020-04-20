<template>
  <div class="idea">
    <div class="idea_card">
      <div class="idea_title">{{ idea.title }}
        <div class="count">
          <span v-if="isLiked" @click="deleteLike()">
            <i class="fa fa-thumbs-up" aria-hidden="true"></i> {{ count }}
          </span>
          <span v-else @click="registerLike()">
            <i class="fa fa-thumbs-o-up" aria-hidden="true"></i> {{ count }}
          </span>
          <i class="fa fa-commenting-o" aria-hidden="true"></i> {{ idea.comments.length }}
        </div>
      </div>
      <div class="idea_content">{{ idea.content }}</div>
      <p v-if='idea.plan' @click="planningPage" class="pranning_page">プランニングへ</p>
      <p v-if='company_admin==true' class="idea_user_name"><i class="fa fa-user" aria-hidden="true"></i>{{ idea.user.name }}</p>
    </div>
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
</template>

<script>
import axios from 'axios'
axios.defaults.headers.common = {
  'X-Requested-With': 'XMLHttpRequest',
  'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
};

export default {
  props: ['idea'],
  data: function() {
    return{
      editing: false,
      message: "",
      user_id: sharedData.user_id,
      company_admin: sharedData.company_admin,
      likeList: [],
      // plan_id: this.idea.plan.id,
    }
  },
  computed: {
    // いいね数を返す
    count() {
      return this.likeList.length
    },
    // ログインユーザが既にいいねしているかを判定する
    isLiked() {
      if (this.likeList.length === 0) { return false }
      return Boolean(this.findLikeId())
    }
  },
  // Vueインスタンスの作成・初期化直後に実行される
  created: function() {
    this.fetchLikeByIdeaId().then(result => {
      this.likeList = result
    })
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

    // rails側のlikes/indexアクションにリクエストするメソッド
    fetchLikeByIdeaId: async function() {
      const res = await axios.get(`/api/likes/?idea_id=${this.idea.id}`)
      if (res.status !== 200) { process.exit() }
      return res.data
    },
    // rails側のlikes/createアクションにリクエストするメソッド
    registerLike: async function() {
      const res = await axios.post('/api/likes', { idea_id: this.idea.id })
      if (res.status !== 201) { process.exit() }
      this.fetchLikeByIdeaId().then(result => {
        this.likeList = result
      })
    },
    // rails側のlikes/destroyアクションにリクエストするメソッド
    deleteLike: async function() {
      const likeId = this.findLikeId()
      const res = await axios.delete(`/api/likes/${likeId}`)
      if (res.status !== 200) { process.exit() }
      this.likeList = this.likeList.filter(n => n.id !== likeId)
    },
    // ログインユーザがいいねしているlikeモデルのidを返す
    findLikeId: function() {
      const like = this.likeList.find((like) => {
        return (like.user_id === this.user_id)
      })
      if (like) { return like.id }
    },


    planningPage: function() {
      location.href = `/ideas/${this.idea.id}/plans/${this.idea.plan.id}`
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

.idea_user_name{
  text-align: right;
}

.card-body{
  padding: 10px;
}

.pranning_page{
  font-size: 0.8rem;
  cursor: pointer;
  color: #0056b3;
}
.pranning_page:hover{
  opacity: 0.5;
}

</style>