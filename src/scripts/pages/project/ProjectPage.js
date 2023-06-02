import { onMounted } from "vue";
export default {
    setup(props) {
        // lifecycle hooks
        onMounted(() => {
            console.log(`The initial of Project Page`);
        });

        return;
    }
}