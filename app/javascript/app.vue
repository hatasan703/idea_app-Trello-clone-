<template>
  <draggable v-model="ideas" :options="{group: 'ideas'}" class="board dragArea" @end="ideaMoved">
    <idea v-for="(idea, index) in ideas" :idea="idea"></idea> 

    <div class="idea">
      <a v-if="!editing" v-on:click="startEditing">Add a idea</a>
      <textarea v-if="editing" ref="message" v-model="message" class="form-control mb-1"></textarea>
      <button v-if="editing" v-on:click="submitMessage" class="btn btn-secondary">Add</button>
      <a v-if="editing" v-on:click="editing=false">Cancel</a>
    </div>

  </draggable>
</template>

<script>
import draggable from 'vuedraggable'
import idea from 'components/idea'

export default {
  components: { draggable, idea },

  props: ["original_ideas"],
  data: function() {
    return{
      ideas: this.original_ideas,
      editing: false,
      message: "",
    }
  },
  methods: {
    // リストの追加
     startEditing: function() {
      this.editing = true
      this.$nextTick(() => { this.$refs.message.focus() }) //カード追加時にフォームを入力状態にする
    },
    // リストのソート
    ideaMoved: function(event) {
      var data =  new FormData
      data.append("idea[position]", event.newIndex + 1)

      Rails.ajax({
        beforeSend: () => true,
        url: `/ideas/${this.ideas[event.newIndex].id}/move`,
        type: "PATCH",
        data: data,
        dataType: "json",
      })
    },

     // カードの新規作成
    submitMessage: function() {
      var data = new FormData
      data.append("idea[content]", this.message)

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
    }
  }
}
</script>

<style scoped>

.dragArea {
  min-height: 10px;
}

.board{
  
  white-space: nowrap;
  overflow-x: auto;
}

.idea{
  background: #E2E4E6;
  border-radius: 3px;
  display: inline-block;
  margin-right: 20px;
  padding: 10px;
  vertical-align: top;
  width: 270px;
}


</style>
