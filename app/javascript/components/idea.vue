<template>
  <div class="idea">
    <h6>{{ idea.content }}</h6>
    <ideaEdit :ideaEdit="ideaEdit"></ideaEdit>

    <draggable v-model="idea.memos" :options="{group: 'memos'}" class="dragArea" @change="memoMoved">
      <memo v-for="memo in idea.memos" :memo="memo" :idea='idea'></memo>
    </draggable>

    <a v-if="!editing" v-on:click="startEditing">Add a memo</a>
    <textarea v-if="editing" ref="message" v-model="message" class="form-control mb-1"></textarea>
    <button v-if="editing" v-on:click="submitMessage" class="btn btn-secondary">Add</button>
    <a v-if="editing" v-on:click="editing=false">Cancel</a>

  </div>
</template>

<script>
import draggable from 'vuedraggable'
import memo from 'components/memo'
import ideaEdit from 'components/ideaEdit'

export default {
  components: { memo, draggable, ideaEdit },
  props: ["idea"],

  data: function() {
    return {
      ideaEdit: this.idea,
      editing: false,
      message: ""
    }
  },

  methods: {
    // リスト(content)編集（モーダル）
    closeModal: function(event) {
      if (event.target.classList.contains("modal")) { this.editing = false }
    },

  //   save: function() {
  //     var data = new FormData
  //     data.append("idea[content]", this.content)

  //     Rails.ajax({
  //       beforeSend: () => true,
  //       url: `/ideas/${this.idea.id}`,
  //       type: "PATCH",
  //       data: data,
  //       dataType: "json",
  //       success: (data) => {
  //         const idea_index = window.store.ideas.findIndex((item) => item.id == this.idea.id)
  //         window.store.ideas.splice(idea_index, 1, data)
  //         this.editing = false
  //       }
  //     })
  //   },

    // destroy: function() {
    //   var data = new FormData
    //   data.append("idea[content]", this.content)

    //   Rails.ajax({
    //     beforeSend: () => true,
    //     url: `/ideas/${this.idea.id}`,
    //     type: "DELETE",
    //     data: data,
    //     dataType: "json",
    //     success: (data) => {
    //       const idea_index = window.store.ideas.findIndex((item) => item.id == this.idea.id)
    //       window.store.ideas.splice(idea_index, 1)
    //       this.editing = false
    //     }
    //   })
    // },

    startEditing: function() {
      this.editing = true
      this.$nextTick(() => { this.$refs.message.focus() }) //カード追加時にフォームを入力状態にする
    },

        // カードのソートと別リストへの移動
    memoMoved: function(event) {
      const evt = event.added || event.moved
      if (evt == undefined) { return }

      const element = evt.element 
      const idea_index = window.store.ideas.findIndex((idea) => {
        return idea.memos.find((memo) => {
          return memo.id === element.id
        })
      })

      var data =  new FormData
      data.append("memo[idea_id]", window.store.ideas[idea_index].id)
      data.append("memo[position]", evt.newIndex + 1)

      Rails.ajax({
        url: `/memos/${element.id}/move`,
        type: "PATCH",
        data: data,
        dataType: "json"
      })
    },

     // カードの新規作成
    submitMessage: function() {
      var data = new FormData
      data.append("memo[idea_id]", this.idea.id)
      data.append("memo[content]", this.message)

      Rails.ajax({
        url: "/memos",
        type: "POST",
        data: data,
        dataType: "json",
        beforeSend: function() { return true },
        success: (data) => {
          const index = window.store.ideas.findIndex(item => item.id == this.idea.id)
          window.store.ideas[index].memos.push(data)
          this.message = ""
          this.$nextTick(() => { this.$refs.message.focus() }) //カード追加時に次のフォームを入力状態にする
        }
      })
    }
  }
}
</script>

<style scoped>

.dragArea {
  min-height: 10px;
}


</style>