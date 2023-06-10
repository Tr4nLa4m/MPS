import { onMounted } from "vue";
import HeaderProjectLayout from "@/views/layouts/HeaderProjectLayout.vue";
export default {
    components : {HeaderProjectLayout},
    setup(props) {
        // lifecycle hooks
        onMounted(() => {
            console.log(`The initial of Project Page`);
        });

        return;
    }
}