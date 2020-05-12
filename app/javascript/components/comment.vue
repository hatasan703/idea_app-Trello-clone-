<template>
  <div class="idea">
    <div class="idea_card">
      <div v-if='isAdmin' class="dropdown">
        <button class="" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
          <i class="fa fa-bars" aria-hidden="true"></i>
        </button>
        <ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
          <li @click="privateAction" class="dropdown_action">非公開にする</li>
        </ul>
      </div>
      <div class="idea_title">{{ idea.title }}</div>
      <div class="idea_content">{{ idea.content }}</div>
      
      <div class="count">
        <i v-if='idea.plan' @click="planningPage" class="fa fa-line-chart pranning_page" aria-hidden="true"></i>
        <span class="good_btn">
          <span v-if="isLiked" @click="deleteLike()">
            <i class="fa fa-thumbs-up" aria-hidden="true"></i> {{ count }}
          </span>
          <span v-else @click="registerLike()">
            <i class="fa fa-thumbs-o-up" aria-hidden="true"></i> {{ count }}
          </span>
        </span>
        <span class="comments_count">
          <i class="fa fa-commenting-o" aria-hidden="true"></i> {{ idea.comments.length }}
        </span>
        <span class="join_count">
          <i @click="joinModal=true" class="fa fa-handshake-o" aria-hidden="true"></i> {{ joinList.length }}
          <div v-if='joinModal' class="modal-backdrop show"></div>
          <div v-if='joinModal' @click="closeJoin" class="modal show" style="display: block">
            <div class="modal-dialog">
              <div class="modal-content">
                <div class="modal-body">
                  参加メンバー
                  <li v-for="user in idea.users" :key="user.id">
                    {{ user.name }}/
                  </li>
                  <div class="join_title">チームへの参加表明</div>
                  <div v-if="isJoined" class="join_btn">参加表明済みです</div>
                  <div v-else @click="registerJoin" class="button join_btn">参加</div>
                </div>
              </div>
            </div>
          </div>
        </span>
      </div>
      
      <p v-if='isAdmin' class="idea_user_name"><i class="fa fa-user" aria-hidden="true"></i>{{ idea.user.name }}</p>
    </div>

    <div v-for="comment in idea.comments" :key="comment.id" class="comment_card">
      <div class="comments">
        <div class="user_icon">
          <div class="user_name">
            {{ comment.user.name }}
          </div>
        </div>
        <div class="comment_content">
          <p>{{comment.content}}
            <span v-if='currentUser.id == comment.user_id' @click="destroy(comment, $event)" type="button"><i class="fa fa-trash-o" aria-hidden="true"></i></span>
          </p>
        </div>
      </div>
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
  props: {
    idea: '',
  },
  data: function() {
    return{
      editing: false,
      message: "",
      currentUser: sharedData.user,
      companyAdmin: sharedData.company_admin,
      likeList: [],
      joinModal: false,
      joinList: [],
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
    },
    // ログインユーザが既にideaに参加しているかを判定する
    isJoined() {
      if (this.joinList.length === 0) { return false }
      return Boolean(this.findJoinId())
    },
    // 会社管理者かどうかを判定
    isAdmin() {
      if (this.companyAdmin==true) { return true }
    },
  },
  // Vueインスタンスの作成・初期化直後に実行される
  created: function() {
    this.fetchLikeByIdeaId().then(result => {
      this.likeList = result
    })
  },
  created: function() {
    this.fetchJoinByIdeaId().then(result => {
      this.joinList = result
    })
  },

  methods: {

    closeJoin: function(event) {
      if (event.target.classList.contains("modal")) { this.joinModal = false }
    },

      // アイディア非公開(ideas#update)
    privateAction: function() {
      var data = new FormData
      data.append("idea[open]", false)

      Rails.ajax({
        beforeSend: () => true,
        url: `${this.idea.id}/hidden`,
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


    startEditing: function() {
      this.editing = true
      this.$nextTick(() => { this.$refs.message.focus() }) //コメント追加時にフォームを入力状態にする
    },

    // コメントの新規作成
    submitMessage: function() {
      var data = new FormData
      data.append("comment[content]", this.message)

      Rails.ajax({
        url: `/ideas/${this.idea.id}/comments`,
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
        url: `/ideas/${this.idea.id}/comments/${comment.id}`,
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
        return (like.user_id === this.currentUser.id)
      })
      if (like) { return like.id }
    },


    planningPage: function() {
      location.href = `/ideas/${this.idea.id}/plans/${this.idea.plan.id}`
    },

    // idea参加状態(ideas/joins#index)
    fetchJoinByIdeaId: async function() {
      const res = await axios.get(`/joins/?idea_id=${this.idea.id}`)
      if (res.status !== 200) { process.exit() }
      return res.data
    },

    // ideaに参加する(ideas/joins#create)
    registerJoin: async function() {
      const res = await axios.post('/joins', { idea_id: this.idea.id })
      if (res.status !== 201) { process.exit() }
      this.fetchJoinByIdeaId().then(result => {
        this.joinList = result
      })
    },

    // ログインユーザが参加しているしているidea_memberモデルのidを返す
    findJoinId: function() {
      const join = this.joinList.find((join) => {
        return (join.user_id === this.currentUser.id)
      })
      if (join) { return join.id }
    },


  }
  
}
</script>



<style>

.idea{
  color: #172b4d;
  background: #ebecf0;
  border-radius: 3px;
  display: inline-block;
  margin: 0 0 20px 20px;
  padding: 10px 15px;
  vertical-align: top;
  width: 250px;
}

.idea_card{
  display: inline-block;
  min-width: 230px;
}

.idea_title{
  font-weight: bold;
  font-size: 15px;
}

.idea_content{
  font-size: 13px;
  margin-bottom: 1rem;
}

.count,
.idea_user_name{
  text-align: right;
  margin-right: 15px;
  font-size: 0.8rem;
}
.modal-content{
  text-align: left;
}

.card-body{
  padding: 10px;
}

.pranning_page{
  font-size: 0.8rem;
  cursor: pointer;
  color: #0056b3;
  margin-right: 5px;
}
.pranning_page:hover{
  opacity: 0.5;
}
.pranning_page,
.good_btn,
.comments_count,
.news_page_btn{
  margin-right:8px;
}


/* 参加表明 */

.join_title{
  text-align: center;
  font-size: 13px;
}

.join_btn{
  padding: 0.5rem 1rem;
  font-size: 1.171875rem;
  line-height: 1.5;
  border-radius: 0.3rem;
  text-align: center;
  color: #fff;
  background-color: #F39C12;
  border-color: #F39C12;
  cursor: pointer;
}
.join_btn:hover{
  opacity: 0.5;
}
.button {
  width: 100px;
  margin: 0 auto;
}

/* コメント */
.comment_card{
  display: flex;
}

.comments {
  width: 100%;
  margin: 10px 0;
  overflow: hidden;
}

.user_name{
  font-size: 13px;
  word-wrap: break-word;
}

.comments .user_icon {
  float: left;
  margin-right: -50px;
  width: 40px;
}

.comments .user_icon img{
  width: 100%;
  height: auto;
  border-radius: 50%;
}
.comment_content {
  display: inline-block;
  position: relative; 
  margin: 0 0 0 50px;
  padding: 10px;
  width: 170px;
  border-radius: 12px;
  background: #fff;
  word-wrap: break-word;
}

.comment_content:after {
  content: "";
  display: inline-block;
  position: absolute;
  top: 3px; 
  left: -19px;
  border: 8px solid transparent;
  border-right: 18px solid #fff;
  -webkit-transform: rotate(35deg);
  transform: rotate(35deg);
}
.comment_content p {
  margin: 0;
  padding: 0;
}


</style>