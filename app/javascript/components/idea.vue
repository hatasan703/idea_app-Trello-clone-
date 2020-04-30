<template>
  <div class="idea">

    <ideaEdit :idea="idea"></ideaEdit>

    <draggable v-model="idea.memos" :options="{group: 'memos'}" class="dragArea" @change="memoMoved">
      <memo v-for="memo in idea.memos" :key="memo.id" :memo="memo" :idea='idea'></memo>
    </draggable>
    <i v-if="!editing" v-on:click="startEditing" class="fa fa-plus-circle" aria-hidden="true">
      メモを追加
    </i> 
    <textarea v-if="editing" ref="message" v-model="message" class="form-control mb-1 memo_form"></textarea>
    <button v-if="editing" v-on:click="submitMessage" class="btn btn-secondary">メモを追加</button>
    <i v-if="editing" v-on:click="editing=false" class="fa fa-remove" aria-hidden="true"></i>


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
      message: "",
    }
  },

  methods: {

    startEditing: function() {
      this.editing = true
      this.$nextTick(() => { this.$refs.message.focus() }) //メモ追加時にフォームを入力状態にする
    },

    // メモのソートと別アイディアへの移動
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
      data.append("memo[position]", evt.newIndex + 1)

      Rails.ajax({
        url: `/ideas/${window.store.ideas[idea_index].id}/memos/${element.id}/move`,
        type: "PATCH",
        data: data,
        dataType: "json"
      })
    },

     // メモの新規作成
    submitMessage: function() {
      var data = new FormData
      data.append("memo[content]", this.message)

      Rails.ajax({
        url: `/ideas/${this.idea.id}/memos`,
        type: "POST",
        data: data,
        dataType: "json",
        beforeSend: function() { return true },
        success: (data) => {
          const index = window.store.ideas.findIndex(item => item.id == this.idea.id)
          window.store.ideas[index].memos.push(data)
          this.message = ""
          this.$nextTick(() => { this.$refs.message.focus() }) //メモ追加時に次のフォームを入力状態にする
        }
      })
    }

  }
}
</script>


<style lang="scss" scoped>

.dragArea {
  min-height: 10px;
}

.fa-remove{
  color: #6b778c;
  margin: 10px 0 0 5px;
  font-size: 20px;
} 

</style>