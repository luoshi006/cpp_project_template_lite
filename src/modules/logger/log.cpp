#include "log.h"
#include "spdlog/sinks/stdout_color_sinks.h"
#include "spdlog/spdlog.h"
#include <memory>
#include <string>

namespace cpt::base {

std::shared_ptr<Log::Logger> Log::m_logger = nullptr;

void Log::init(LogLevel _level)
{
    // const size_t max_log_bytes = 1024*1024*50;      // 50 Mb
    // const size_t max_log_sizes = 5;                 // 5 log file
    // auto file = spdlog::rotating_logger_mt("some_logger_name", "logs/rotating.txt", max_size, max_files);

    auto console = std::make_shared<spdlog::sinks::stdout_color_sink_mt>();
    console->set_level(_level);
    console->set_pattern("%H:%M:%S:%e [%^%l%$] %v");

    const spdlog::sinks_init_list sink_list = { console };
    m_logger = std::make_shared<spdlog::logger>("hud_logger", sink_list.begin(), sink_list.end());
}

} // namespace