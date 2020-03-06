<template>
  <div class="idea">

    <ideaEdit :idea="idea"></ideaEdit>

    <draggable v-model="idea.memos" :options="{group: 'memos'}" class="dragArea" @change="memoMoved">
      <memo v-for="memo in idea.memos" :key="memo.id" :memo="memo" :idea='idea'></memo>
    </draggable>

    <a v-if="!editing" v-on:click="startEditing"><i class="fa fa-plus-circle" aria-hidden="true"></i> メモを追加</a>
    <textarea v-if="editing" ref="message" v-model="message" class="form-control mb-1 content_form"></textarea>
    <button v-if="editing" v-on:click="submitMessage" class="btn btn-secondary">メモを追加</button>
    <a v-if="editing" v-on:click="editing=false">キャンセル</a>

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
    // アイディア(content)編集（モーダル）
    closeModal: function(event) {
      if (event.target.classList.contains("modal")) { this.editing = false }
    },

    startEditing: function() {
      this.editing = true
      this.$nextTick(() => { this.$refs.message.focus() }) //カード追加時にフォームを入力状態にする
    },

        // アイディアのソートと別リストへの移動
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

     // メモの新規作成
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


<style lang="scss" scoped>
@import "../assets/test.scss";

.dragArea {
  min-height: 10px;
}


/* .content_form{
  height: 200px;
} */

</style>